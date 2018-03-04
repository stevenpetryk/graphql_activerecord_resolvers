module GraphQLActiveRecordResolvers
  class GraphQLAssociation
    attr_reader :klass, :irep_node, :root

    def initialize(klass:, irep_node:, root:)
      @klass = klass
      @irep_node = irep_node
      @root = root
    end

    def build_includes_tree
      if root
        child_associations.map(&:build_includes_tree)
      elsif child_associations.any?
        {
          irep_node_association_name => child_associations.map(&:build_includes_tree),
        }
      else
        irep_node_association_name
      end
    end

    private

    def child_irep_nodes_that_map_to_associations
      irep_node.children.select do |_, irep_node|
        association_names.include?(irep_node_association_name(irep_node))
      end.values
    end

    def child_associations
      child_irep_nodes_that_map_to_associations.map do |child_irep_node|
        GraphQLAssociation.new(
          klass: klass_for_child_irep_node(child_irep_node),
          irep_node: child_irep_node,
          root: false,
        )
      end
    end

    def field_for_irep_node(irep_node)
      irep_node.definitions.values.first
    end

    def associations
      klass.reflect_on_all_associations
    end

    def association_names
      associations.map(&:name).map(&:to_s)
    end

    def irep_node_association_name(irep_node = self.irep_node)
      field = field_for_irep_node(irep_node)
      (field.metadata[:association_name] || field.name).to_s
    end

    def klass_for_child_irep_node(child_irep_node)
      name = irep_node_association_name(child_irep_node)
      associations.detect { |association| association.name.to_s == name }.klass
    end
  end
end
