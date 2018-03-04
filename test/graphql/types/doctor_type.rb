module Types
  DoctorType = GraphQL::ObjectType.define do
    name "Doctor"

    field :name, !types.String
    field :patients, !types[Types::PersonType]
  end
end
