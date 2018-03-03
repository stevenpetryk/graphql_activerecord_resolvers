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
  belongs_to :location
end

class Pet < ActiveRecord::Base
  belongs_to :person
end
