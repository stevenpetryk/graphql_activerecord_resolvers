require_relative "./country_type"
require_relative "./location_type"
require_relative "./person_type"
require_relative "./pet_type"

module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"

    field :countries do
      type types[Types::CountryType]
      type types[Types::CountryType]

      resolve ->(_, _, _) { Country.all }
    end
  end
end
