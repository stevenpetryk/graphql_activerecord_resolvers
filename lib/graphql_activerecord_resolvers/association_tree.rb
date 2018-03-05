module GraphQLActiveRecordResolvers
  class AssociationTree
    attr_reader :klass, :irep_node

    def initialize(klass, ctx)
      @klass = klass
      @irep_node = ctx.irep_node
    end

    def includes_arguments
      @includes_arguments ||=
        Association.
          new(
            klass: klass,
            irep_node: irep_node,
            root: true,
          ).
          build_includes_arguments
    end
  end
end
