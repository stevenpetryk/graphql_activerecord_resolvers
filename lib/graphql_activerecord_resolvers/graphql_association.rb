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
          field.name => child_associations.map(&:build_includes_tree)
        }
      else
        field.name
      end
    end

    private

    def child_fields
      selections.map do |selection|
        [selection, schema.get_field(field_type, selection.name)]
      end
    end

    def child_fields_that_are_also_associations
      child_fields.select do |(_, field)|
        association_names.map(&:to_s).include?(field.name.to_s)
      end
    end

    def child_associations
      child_fields_that_are_also_associations.map do |(selection, field)|
        GraphQLAssociation.new(
          schema: schema,
          klass: klass_for_association_name(field.name),
          field: field,
          selections: selection.selections,
          root: false
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
      associations.map(&:name)
    end

    def klass_for_association_name(name)
      associations.find { |association| association.name.to_s == name.to_s }.klass
    end
  end
end
