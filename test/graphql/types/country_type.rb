module Types
  CountryType = GraphQL::ObjectType.define do
    name "Country"

    field :name, !types.String
  end
end
