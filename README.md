## Andrey Datsenko Gotoinc test

### Using pure Ruby without RailsImplement custom Validation module that:

1. Contains a class method validate. This method takes two arguments: attribute
name and options with validation types and rules. These are possible validation
types (you can implement your own as well):

  - `presence` - requires an attribute to be neither `nil` nor an empty string.
  Usage example:
  `validate :name, presence: true`

  - `format` - requires an attribute to match the passed regular expression.
  Usage example:
  `validate :number, format: /A-Z{0,3}/`

  - `type` - requires an attribute to be an instance of the passed class.
  Usage example:
  `validate :owner, type: User`

2. Contains an instance method `validate!` which runs all checks and validations,
that added to a class via the class method `validate`. In case of any mismatch it raises
an exception with a message that says what exact validation failed.

3. Contains an instance method `valid?` that returns true if all validations pass
and false if there is any validation fail.

### Usage

#### Without Docker
`$ bundle install`
`$ rake` or `$ rspec`

#### With Docker

`$ docker build -t a-datsenko-test .`
`$ docker run a-datsenko-test`
`$ docker rmi -f a-datsenko-test`