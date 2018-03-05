require_relative "graphql_types/country_type"
require_relative "graphql_types/location_type"
require_relative "graphql_types/person_type"
require_relative "graphql_types/doctor_type"
require_relative "graphql_types/grocery_item_type"
require_relative "graphql_types/pet_type"

module Minitest
  class Test
    attr_reader :data, :errors

    def assert_includes_arguments(query_string, expected_includes_tree)
      resolver = ->(_obj, _args, ctx) do
        resolver = GraphQLActiveRecordResolvers::AssociationTree.new(klass, ctx)
        assert_equal(resolver.includes_arguments, expected_includes_tree)
        []
      end

      result = schema(resolver).execute(query_string)
      flunk "\nGraphQL errors:\n\n#{result['errors']}" if result["errors"]
    end
  end
end
