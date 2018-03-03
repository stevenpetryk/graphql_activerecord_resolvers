require "test_helper"

class GraphQLActiveRecordResolversTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GraphQLActiveRecordResolvers::VERSION
  end

  def test_regular_collections_efficiency
    assert_equal(includes_tree("{ countries { name } }", Country), [])
  end

  def test_nested_collections_efficiency
    assert_equal(includes_tree(<<-GRAPHQL, Country), ["locations"])
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

  def test_doubly_nested_collections_efficiency
    assert_equal(includes_tree(<<-GRAPHQL, Country), [{ "locations" => ["people"] }])
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

  def test_belongs_to_efficiency
    assert_equal(includes_tree(<<-GRAPHQL, Location), ["country"])
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

  def test_renamed_has_many_through_association
    assert_equal(includes_tree(<<-GRAPHQL, Country), ["animals"])
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
