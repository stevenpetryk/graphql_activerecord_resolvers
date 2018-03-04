module Types
  PersonType = GraphQL::ObjectType.define do
    name "Person"

    field :name, !types.String
    field :pets, !types[Types::PetType]
    field :groceries, !types[Types::GroceryItemType]
    field :location, Types::LocationType
    field :doctor, Types::DoctorType
  end
end
