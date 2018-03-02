$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "graphql_activerecord_resolvers"

require "active_record"
require "bullet"
require "factory_bot"
require "graphql"
require "minitest"
require "pry"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

require File.dirname(__FILE__) + "/database/seeds"

require "minitest/autorun"
require "minitest/pride"
