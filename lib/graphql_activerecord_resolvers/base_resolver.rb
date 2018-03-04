module GraphQLActiveRecordResolvers
  class BaseResolver
    attr_reader :ctx, :schema, :query

    def self.resolve_collection(klass)
      ->(_obj, _args, ctx) do
        new(klass, ctx).resolve
      end
    end

    def initialize(klass, ctx)
      @klass = klass
      @ctx = ctx
      @schema = ctx.schema
      @query = ctx.query
    end

    def resolve
      if includes_tree
        klass.includes(includes_tree)
      else
        klass.all
      end
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

    def root_field
      schema.query.get_field(ctx.ast_node.name)
    end

    def root_selections
      ctx.ast_node.selections
    end

    def klass
      if @klass.is_a? String
        @klass.constantize
      else
        @klass
      end
    end
  end
end
