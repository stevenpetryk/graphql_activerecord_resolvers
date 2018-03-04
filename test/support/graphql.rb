require_relative "../graphql/graphql_schema"

module Minitest
  class Test
    attr_reader :data, :errors

    def includes_tree(query_string, klass)
      klass.cattr_accessor :includes_tree

      def klass.each_with_index
        [].each_with_index
      end

      def klass.includes(tree)
        self.includes_tree = tree
        self
      end

      result = GraphQLSchema.
        schema_with_resolved(klass).
        execute(query_string)

      flunk "\nGraphQL errors:\n\n#{errors}" if result["errors"]

      klass.includes_tree
    end
  end
end
