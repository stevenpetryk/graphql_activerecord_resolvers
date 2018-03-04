require "test_helper"

class AssociationNameTest < Minitest::Test
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

  def test_custom_association_name
    assert_includes_tree(<<-GRAPHQL, [{ "location" => ["country"] }])
      {
        people {
          name
          location {
            name
            mother_land { name }
          }
        }
      }
    GRAPHQL
  end
end
