module GraphQLActiveRecordResolvers
  class GraphQLAssociation
    attr_reader :klass, :schema, :field, :selections, :root

    def initialize(schema:, klass:, field:, selections:, root:)
      @klass = klass
      @schema = schema
      @field = field
      @selections = selections
      @root = root
    end

    def build_includes_tree
      if root
        child_associations.map(&:build_includes_tree)
      elsif child_associations.any?
        {
          field_association_name => child_associations.map(&:build_includes_tree),
        }
      else
        field_association_name
      end
    end

    private

    def child_fields
      selections.map do |selection|
        [selection, schema.get_field(field_type, selection.name)]
      end
    end

    def child_fields_that_are_also_associations
      child_fields.select do |_, field|
        association_names.include?(field_association_name(field))
      end
    end

    def child_associations
      child_fields_that_are_also_associations.map do |(selection, field)|
        GraphQLAssociation.new(
          schema: schema,
          klass: klass_for_child_field(field),
          field: field,
          selections: selection.selections,
          root: false,
        )
      end
    end

    def field_type
      field.type.unwrap
    end

    def associations
      klass.reflect_on_all_associations
    end

    def association_names
      associations.map(&:name).map(&:to_s)
    end

    def field_association_name(field = self.field)
      (field.metadata[:association_name] || field.name).to_s
    end

    def klass_for_child_field(child_field)
      name = field_association_name(child_field)
      associations.detect { |association| association.name.to_s == name }.klass
    end
  end
end
