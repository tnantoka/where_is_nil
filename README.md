# WhereIsNil

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
