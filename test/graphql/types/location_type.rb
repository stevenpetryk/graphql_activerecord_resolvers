module Types
  LocationType = GraphQL::ObjectType.define do
    name "Location"

    field :name, !types.String
    field :people, !types[Types::PersonType]
    field :country, Types::CountryType
    field :mother_land do
      type Types::CountryType
      association_name :country
    end
  end
end
