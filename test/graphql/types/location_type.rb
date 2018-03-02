module Types
  LocationType = GraphQL::ObjectType.define do
    name "Location"

    field :name, !types.String
    field :people, !types[Types::PersonType]
  end
end
