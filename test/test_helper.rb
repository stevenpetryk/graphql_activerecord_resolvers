$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "graphql_activerecord_resolvers"

require "active_record"
require "pry"

require "support/database"

require "minitest/autorun"
require "minitest/pride"
