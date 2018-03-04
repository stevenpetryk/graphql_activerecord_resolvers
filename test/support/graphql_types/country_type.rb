module Types
  CountryType = GraphQL::ObjectType.define do
    name "Country"

    field :name, !types.String
    field :locations, !types[Types::LocationType]
    field :animals, !types[Types::PetType]
  end
end
