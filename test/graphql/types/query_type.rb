require_relative "./country_type"
require_relative "./location_type"
require_relative "./person_type"
require_relative "./pet_type"

module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"

    field :countries do
      type types[Types::CountryType]

      resolve GraphQLActiveRecordResolvers::BaseResolver.resolve_collection(Country)
    end

    field :locations do
      type types[Types::LocationType]

      resolve GraphQLActiveRecordResolvers::BaseResolver.resolve_collection(Location)
    end
  end
end
