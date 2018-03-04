require "active_record"

class Country < ActiveRecord::Base
  has_many :locations
  has_many :people, through: :locations
  has_many :animals, through: :people, source: :pets
end

class Location < ActiveRecord::Base
  belongs_to :country
  has_many :people
  has_many :pets, through: :people
end

class Person < ActiveRecord::Base
  has_many :pets
  has_many :groceries
  belongs_to :location
  belongs_to :doctor
end

class Doctor < ActiveRecord::Base
  has_many :patients, class_name: "Person"
end

class Grocery < ActiveRecord::Base
  belongs_to :person
end

class Pet < ActiveRecord::Base
  belongs_to :person
end
