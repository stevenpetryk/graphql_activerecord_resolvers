module Types
  PersonType = GraphQL::ObjectType.define do
    name "Person"

    field :name, !types.String
    field :pets, !types[Types::PetType]
  end
end
