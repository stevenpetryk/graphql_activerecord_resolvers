module GraphQLActiveRecordResolvers
  class BaseResolver
    attr_reader :klass, :ctx

    def initialize(klass, ctx)
      @klass = klass
      @ctx = ctx
    end

    def includes_tree
      @includes_tree ||=
        GraphQLAssociation.
          new(
            schema: schema,
            klass: klass,
            field: root_field,
            selections: root_selections,
            root: true,
          ).
          build_includes_tree
    end

    private

    delegate :schema, to: :ctx

    def root_field
      schema.query.get_field(ctx.ast_node.name)
    end

    def root_selections
      ctx.ast_node.selections
    end
  end
end
