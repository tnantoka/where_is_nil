# WhereIsNil

[![Gem Version](https://badge.fury.io/rb/where_is_nil.svg)](http://badge.fury.io/rb/where_is_nil) [![Code Climate](https://codeclimate.com/github/tnantoka/where_is_nil/badges/gpa.svg)](https://codeclimate.com/github/tnantoka/where_is_nil) [![Circle CI](https://circleci.com/gh/tnantoka/where_is_nil.svg?style=svg)](https://circleci.com/gh/tnantoka/where_is_nil) [![Test Coverage](https://codeclimate.com/github/tnantoka/where_is_nil/badges/coverage.svg)](https://codeclimate.com/github/tnantoka/where_is_nil)

`find_by(nil)` always returns first record. (https://github.com/rails/rails/issues/14867)  
WhereIsNil gives notice when invoke `find_by(nil)` or `find_by(Fixnum)`.

## Requirement

- Rails 4.2

## Installation

```
# Gemfile
gem 'where_is_nil'
```

## Usage

```
$ rails c
> User.find_by(id: 1)
=> #<User id: 1>

> User.find_by(nil)
WhereIsNil::FindByNil: Why do you find by nil? Did you mean `find_by(id: nil)`?

> User.find_by(1)
WhereIsNil::FindByNil: Why do you find by 1? Did you mean `find_by(id: 1)`?
```

## Configuration

```
# config/initializers/where_is_nil.rb

# Enable where_is_nil features.
WhereIsNil.config.enabled = true

# Print error messages to the Rails logger.
WhereIsNil.config.warning_log = true

# Raise `WhereIsNil::FindByNil` errors.
WhereIsNil.config.raise_error = true

# Return nil with `find_by`, Raise `ActiveRecord::NotFound` with `find_by!`.
WhereIsNil.config.not_found = false
```

## Licence

This project rocks and uses MIT-LICENSE.
