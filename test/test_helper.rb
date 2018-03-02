$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "graphql_activerecord_resolvers"

require "active_record"
require "graphql"
require "minitest"
require "pry"

require "support/database"
require "support/graphql"

require "minitest/autorun"
require "minitest/pride"
