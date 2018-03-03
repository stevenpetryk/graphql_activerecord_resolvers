require_relative "../graphql/graphql_schema"

module Minitest
  class Test
    attr_reader :mock_resolver, :data, :errors

    def includes_tree(query_string, klass)
      @mock_resolver = Minitest::Mock.new

      resolver = nil

      mock_resolver = ->(obj, args, ctx) do
        resolver = GraphQLActiveRecordResolvers::BaseResolver.new(klass, ctx)
        []
      end

      result = GraphQLSchema.
        schema_with_resolver(mock_resolver).
        execute(query_string)

      flunk "\nGraphQL errors:\n\n#{errors}" if result["errors"]

      resolver.includes_tree
    end
  end
end
