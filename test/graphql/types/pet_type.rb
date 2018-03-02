module Types
  PetType = GraphQL::ObjectType.define do
    name "Pet"

    field :name, !types.String
    field :person, Types::PersonType
  end
end
