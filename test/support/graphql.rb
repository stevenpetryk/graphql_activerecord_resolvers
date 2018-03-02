require_relative "../graphql/graphql_schema"

module Minitest
  class Test
    attr_reader :data, :errors

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
