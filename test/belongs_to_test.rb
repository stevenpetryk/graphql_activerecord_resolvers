require "test_helper"

class BelongsToTest < Minitest::Test
  def schema(resolver)
    GraphQL::Schema.define do
      query(
        GraphQL::ObjectType.define do
          name "Query"

          field :locations do
            type types[Types::LocationType]
            resolve resolver
          end
        end,
      )
    end
  end

  def klass
    Location
  end

  def test_belongs_to
    assert_includes_arguments(<<-GRAPHQL, ["country"])
      {
        locations {
          name

          country {
            name
          }
        }
      }
    GRAPHQL
  end
end
