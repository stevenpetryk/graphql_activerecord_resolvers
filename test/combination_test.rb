require "test_helper"

class CombinationTest < Minitest::Test
  def schema(resolver)
    GraphQL::Schema.define do
      query(
        GraphQL::ObjectType.define do
          name "Query"

          field :people do
            type types[Types::PersonType]
            resolve resolver
          end
        end,
      )
    end
  end

  def klass
    Person
  end

  def test_combination
    assert_includes_arguments(<<-GRAPHQL, [{ "doctor" => ["patients"] }, "groceries", "pets"])
      {
        people {
          name
          doctor {
            name
            patients { name }
          }
          groceries { name }
          pets { name }
        }
      }
    GRAPHQL
  end
end
