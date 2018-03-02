module Types
  LocationType = GraphQL::ObjectType.define do
    name "Location"

    field :name, !types.String
    field :people, !types[Types::PersonType]
    field :country, Types::CountryType
  end
end
