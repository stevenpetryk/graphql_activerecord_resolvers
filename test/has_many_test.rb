require "test_helper"

class HasManyTest < Minitest::Test
  def schema(resolver)
    GraphQL::Schema.define do
      query(
        GraphQL::ObjectType.define do
          name "Query"

          field :countries do
            type types[Types::CountryType]
            resolve resolver
          end
        end,
      )
    end
  end

  def klass
    Country
  end

  def test_has_many
    assert_includes_arguments(<<-GRAPHQL, ["locations"])
      {
        countries {
          name

          locations {
            name
          }
        }
      }
    GRAPHQL
  end

  def test_double_has_many
    assert_includes_arguments(<<-GRAPHQL, [{ "locations" => ["people"] }])
      {
        countries {
          name

          locations {
            name

            people {
              name
            }
          }
        }
      }
    GRAPHQL
  end

  def test_renamed_has_many_through
    assert_includes_arguments(<<-GRAPHQL, ["animals"])
      {
        countries {
          name

          animals {
            name
          }
        }
      }
    GRAPHQL
  end
end
