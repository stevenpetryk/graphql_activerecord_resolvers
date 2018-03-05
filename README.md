# GraphQL ActiveRecord Resolvers

Build a GraphQL API on Rails, without the N+1's.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "graphql_activerecord_resolvers"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphql_activerecord_resolvers

## Usage

GraphQL marks a new era in API development, one in which the clients dictate what the server
should deliver. But, due to N+1 queries, using GraphQL with Rails is a pain. That's where this gem
comes in.

`graphql_activerecord_resolvers` works with the [graphql] gem. It allows you to easily substitute your
own resolvers for supercharged ones. These resolvers take a look at the schema, the query, and the
context, and automatically build up an `eager_load` instruction that Rails understands.

[graphql]: http://graphql-ruby.org

To use it, simply make the following change to every **root field** in your Query:

```diff
module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"

    field :countries do
      type types[Types::CountryType]

-     resolve ->(_, _, _) { Country.all }
+     resolve ->(_, _, ctx) { Country.preload_graphql_associations(ctx) }
    end

    field :locations do
      type types[Types::LocationType]

-     resolve ->(_, _, _) { Location.all }
+     resolve ->(_, _, ctx) { Location.preload_graphql_associations(ctx) }
    end
  end
end
```

### When field names don't match association names

There's a special case that the resolver can't detect automatically, and that is when you have a
field that resolves to an association but does not match the name of said association. In this case,
you need to explicitly declare the association name on the field. For example:

```diff
class Pet < ActiveRecord::Base
  belongs_to :person
end

# ...

module Types
  PetType = GraphQL::ObjectType.define do
    name "Pet"

    field :owner do
      type Types::PersonType
+     association_name :person
      resolve -> (obj, _, _) { obj.person }
    end
  end
end
```

### What about for fields that return single objects?

Research is still underway on this. The difficulty lies in determining how resolvers would need to
be modified to support eager-loading when requested, but also in such a way that redundant eager
loading doesn't occur.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run
the tests. You can also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new
version, update the version number in `version.rb`, and then run `bundle exec rake release`, which
will create a git tag for the version, push git commits and tags, and push the `.gem` file to
[rubygems.org].

[rubygems.org]: https://rubygems.org

## Contributing

Bug reports and pull requests are welcome [on GitHub].

[on GitHub]: https://github.com/stevenpetryk/graphql_activerecord_resolvers

## License

The gem is available as open source under the terms of the [MIT License].

[MIT License]: https://opensource.org/licenses/MIT
