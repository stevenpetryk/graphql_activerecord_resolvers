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

      GraphQLSchema.
        schema_with_resolver(mock_resolver).
        execute(query_string)

      resolver.includes_tree
    end

    def execute(query, variables: nil)
      result = GraphQLSchema.execute(query, variables: variables)
      @data = result.to_h["data"]
      @errors = result.to_h["errors"]
    end

    def assert_graphql_success
      flunk "\nGraphQL errors:\n\n#{errors}" if errors
    end
  end
end
