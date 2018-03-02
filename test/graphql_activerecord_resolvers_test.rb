require "test_helper"

class GraphQLActiveRecordResolversTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GraphQLActiveRecordResolvers::VERSION
  end

  def test_it_executes_queries
    FactoryBot.create_list(:country, 3)

    assert_equal(run_query(<<-GRAPHQL)["countries"].count, 3)
      {
        countries {
          name
        }
      }
    GRAPHQL
  end
end
