require_relative "types/country_type"
require_relative "types/location_type"
require_relative "types/person_type"
require_relative "types/pet_type"

class GraphQLSchema
  def self.schema_with_resolver(mock_resolver)
    GraphQL::Schema.define do
      query(
        GraphQL::ObjectType.define do
          name "Query"

          field :countries do
            type types[Types::CountryType]
            resolve mock_resolver
          end

          field :locations do
            type types[Types::LocationType]
            resolve mock_resolver
          end
        end
      )
    end
  end
end
