module Types
  GroceryItemType = GraphQL::ObjectType.define do
    name "GroceryItem"

    field :name, !types.String
  end
end
