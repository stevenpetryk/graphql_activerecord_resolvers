require "test_helper"

class GraphQLActiveRecordResolversTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GraphQLActiveRecordResolvers::VERSION
  end

  def test_regular_collections_efficiency
    execute(<<-GRAPHQL)
      {
        countries {
          name
        }
      }
    GRAPHQL

    assert_graphql_success
    assert_no_bullet_warnings
  end

  def test_nested_collections_efficiency
    execute(<<-GRAPHQL)
      {
        countries {
          name

          locations {
            name
          }
        }
      }
    GRAPHQL

    assert_graphql_success
    assert_no_bullet_warnings
  end

  def test_doubly_nested_collections_efficiency
    execute(<<-GRAPHQL)
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

    assert_graphql_success
    assert_no_bullet_warnings
  end

  def test_renamed_has_many_through_association
    execute(<<-GRAPHQL)
      {
        countries {
          name

          animals {
            name
          }
        }
      }
    GRAPHQL

    assert_graphql_success
    assert_no_bullet_warnings
  end
end
