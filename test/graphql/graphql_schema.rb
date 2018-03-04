require_relative "types/country_type"
require_relative "types/location_type"
require_relative "types/person_type"
require_relative "types/doctor_type"
require_relative "types/grocery_item_type"
require_relative "types/pet_type"

class GraphQLSchema
  def self.schema_with_resolved(resolved)
    GraphQL::Schema.define do
      query(
        GraphQL::ObjectType.define do
          name "Query"

          field :countries do
            type types[Types::CountryType]
            resolve ->(_obj, _args, ctx) do
              resolved.eager_load_from_graphql(ctx)
            end
          end

          field :locations do
            type types[Types::LocationType]
            resolve ->(_, _, ctx) do
              resolved.eager_load_from_graphql(ctx)
            end
          end

          field :people do
            type types[Types::PersonType]
            resolve ->(_, _, ctx) do
              resolved.eager_load_from_graphql(ctx)
            end
          end
        end,
      )
    end
  end
end
