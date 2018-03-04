require "active_record"
require "graphql"

module ActiveRecord
  class Base
    def self.eager_load_from_graphql(ctx)
      resolver = GraphQLActiveRecordResolvers::BaseResolver.new(self, ctx)
      includes(resolver.includes_tree)
    end
  end
end

GraphQL::Field.accepts_definitions(
  association_name: GraphQL::Define.assign_metadata_key(:association_name),
)
