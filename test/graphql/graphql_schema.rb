require_relative "types/query_type"

GraphQLSchema = GraphQL::Schema.define do
  query(Types::QueryType)
end
