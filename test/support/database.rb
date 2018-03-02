ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

load File.dirname(__FILE__) + "/../database/schema.rb"
require File.dirname(__FILE__) + "/../database/models.rb"
