require "active_record"
require "graphql"

module ActiveRecord
  class Base
    def self.preload_graphql_associations(ctx)
      association_tree = GraphQLActiveRecordResolvers::AssociationTree.new(self, ctx)
      includes(association_tree.includes_arguments)
    end
  end
end

GraphQL::Field.accepts_definitions(
  association_name: GraphQL::Define.assign_metadata_key(:association_name),
)
