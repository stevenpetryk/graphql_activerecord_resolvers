require_relative "./country_type"

module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"

    field :countries do
      type types[Types::CountryType]

      resolve ->(_, _, _) { Country.all }
    end
  end
end
