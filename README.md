# TinyFilter

[![Gem Version](https://img.shields.io/gem/v/tiny_filter?color=blue&label=version)](https://rubygems.org/gems/tiny_filter)
[![Gem downloads count](https://img.shields.io/gem/dt/tiny_filter)](https://rubygems.org/gems/tiny_filter)
[![Github Actions CI](https://github.com/lassoid/tiny_filter/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/lassoid/tiny_filter/actions/workflows/ci.yml)

TinyFilter is created to provide a simple object-oriented abstraction layer for filtering collections.
It is mainly purposed for ActiveRecord collections, but you can also use it with any enumerable.

```ruby
Post.where(title: "Wow!").filter_by(from: 2.days.ago, to: 1.day.ago).order(:created_at)
```

## Installation

1. Install the gem and add to the application's Gemfile by executing:

   ```shell
   bundle add tiny_filter
   ```

2. Generate an application filter as an entry point to all your future filters:

   ```shell
   bin/rails g tiny_filter:install
   ```

This will generate `ApplicationFilter` inside `app/filters` directory.
This directory is intended to store all your filters.

## Adding a filter

To generate a filter class simply run `tiny_filter:filter` command.

For example, to create a filter class for `Post` with filters `from` and `to`, run:

```shell
bin/rails g tiny_filter:filter post from to
```

This will generate the `PostFilter` class inside the `app/filters` directory with `from` and `to` filters.

Each filter is defined by calling `filters` method inside class body.

`filters` accepts two arguments:
- `key` - a filter name, used as identifier;
- `block` - a block with filter logic, that returns filtered collection and itself accepts two arguments:
  - `scope` - a collection that should be filtered;
  - `value` - a value for filtering.

When you perform filtering, provided key indicate filter `key` and provided value is passed to `value` param in corresponding filter `block`.
`scope`s receive collections in a pipeline manner:
_first_ executed filter receives _original collection_,
_second and further_ receive the _return collection_ of the previous filter.

To execute filtering, simply call `filter` with the initial scope and options provided.

```ruby
class UserFilter < ApplicationFilter
  filters(:name) { |scope, value| scope.where(first_name: value) }
  filters(:surname) { |scope, value| scope.where(last_name: value) }
end

UserFilter.filter(User, name: "John", surname: "Doe")
# Which is equivalent to:
# User.where(first_name: "John").where(last_name: "Doe")
```

Notice, that your filters _must_ return the same scope type as they accept.
It guarantees that scope behaves the same way as in other filters in this class.

```ruby
filters(:title) { |scope, value| scope.where("title ILIKE ?", value) }

# bad - scope is an ActiveRecord collection, but the return value is an array.
filters(:from) { |scope, value| scope.select { |e| e.created_at >= value } }

# good - scope and return value are both ActiveRecord collections.
filters(:from) { |scope, value| scope.where("created_at >= ?", value) }
```

Thus if the initial scope for filtering is an ActiveRecord collection,
it is a bad practice for filter to return not an ActiveRecord collection.
Otherwise you can face errors depending on the provided options order.

## ORM integration

### ActiveRecord

TinyFilter provides a simple concern, that adds just one method `filter_by`, that can be used in ActiveRecord method chaining.

Just include `TinyFilter::Concern` in your model and that's all!

```ruby
class Post < ApplicationRecord
  include TinyFilter::Concern
end
```

Now you can use filtering everywhere in your model method chaining.

```ruby
Post.where(title: "something interesting").filter_by(from: 2.days.ago, to: 1.day.ago).order(:title)
Post.filter_by(from: 1.year.ago)
```

### Sequel

The previously mentioned filter concern can also be used in Sequel models.

```ruby
class Artist < Sequel::Model
  include TinyFilter::Concern
end
```

Querying examples:

```ruby
Artist.where(name: "Kirill").filter_by(from: 2.days.ago, to: 1.day.ago).order(:name).all
Artist.filter_by(from: 1.year.ago).all
```

### Naming convention

By default a filter class and a model are mapped by a _model name_ with a _suffix_ `Filter`.
For example, the model `My::Class` by default will use the `My::ClassFilter` as a filter class.

You can customize this behavior by implementing a `filter_class` class method with an appropriate class as a return value.

```ruby
class My::Class < ApplicationRecord
   # ...
   def self.filter_class
      CustomFilter
   end
   # ...
end
```

## Using with Plain objects

You can use filters with non-ActiveRecord collections like so:

```ruby
options    # filter options, for example: `{ from: 2.days.ago, to: 1.day.ago }`
collection # can be any Enumerable: array, hash, your custom collection, etc etc

MyFilter.filter(collection, options)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests.
You can also run `bin/rubocop` to lint the source code
and `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`.
To release a new version, update the version number in `version.rb`, and then run `bin/rake release`,
which will create a git tag for the version, push git commits and the created tag,
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lassoid/tiny_filter.
This project is intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [code of conduct](https://github.com/lassoid/tiny_filter/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TinyFilter project's codebases, issue trackers, chat rooms and mailing lists
is expected to follow the [code of conduct](https://github.com/lassoid/tiny_filter/blob/main/CODE_OF_CONDUCT.md).
