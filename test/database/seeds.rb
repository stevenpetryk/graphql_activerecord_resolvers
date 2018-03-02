2.times do
  country = FactoryBot.create(:country)

  3.times do
    location = FactoryBot.create(:location, country: country)

    5.times do
      person = FactoryBot.create(:person, location: location)

      FactoryBot.create(:pet, person: person)
    end
  end
end
