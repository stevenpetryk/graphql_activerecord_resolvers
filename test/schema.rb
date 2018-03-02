ActiveRecord::Schema.define do
  self.verbose = false

  create_table :locations, force: true do |t|
    t.string :name
    t.references :country
  end

  create_table :countries, force: true do |t|
    t.string :name
  end

  create_table :people, force: true do |t|
    t.string :name
    t.references :location
  end

  create_table :pets, force: true do |t|
    t.string :name
    t.references :person
  end
end
