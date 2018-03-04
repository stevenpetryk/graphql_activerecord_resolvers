require_relative "../graphql/graphql_schema"

module Minitest
  class Test
    attr_reader :data, :errors

    def includes_tree(query_string, klass)
      includes_tree = nil

      mock_resolver = ->(_obj, _args, ctx) do
        includes_tree = GraphQLActiveRecordResolvers::BaseResolver.new(klass, ctx).includes_tree
        []
      end

      result = GraphQLSchema.
        schema_with_resolver(mock_resolver).
        execute(query_string)

      flunk "\nGraphQL errors:\n\n#{errors}" if result["errors"]

      includes_tree
    end
  end
end
