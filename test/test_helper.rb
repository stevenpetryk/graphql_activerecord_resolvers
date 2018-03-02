$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "graphql_activerecord_resolvers"

require "active_record"
require "pry"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
load File.dirname(__FILE__) + "/schema.rb"
require File.dirname(__FILE__) + "/models.rb"

require "minitest/autorun"
