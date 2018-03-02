require_relative "../graphql/graphql_schema"

module Minitest
  class Test
    def run_query(query, variables: nil)
      GraphQLSchema.execute(query, variables: variables).to_h["data"]
    end
  end
end
