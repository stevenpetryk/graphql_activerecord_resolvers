module GraphQLActiveRecordResolvers
  class IncludesTree
    attr_reader :klass, :irep_node

    def initialize(klass, ctx)
      @klass = klass
      @irep_node = ctx.irep_node
    end

    def includes_tree
      @includes_tree ||=
        GraphQLAssociation.
          new(
            klass: klass,
            irep_node: irep_node,
            root: true,
          ).
          build_includes_tree
    end
  end
end
