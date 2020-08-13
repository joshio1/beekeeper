# Beekeeper
This is a library for error processing, logging and rendering.

## Description

* This gem prints an error and a trimmed down version of the backtrace in case of ANY non-200 response in any application.
* This gem enables the application code(models, controllers and libs) code to be clean and concise. Since, now, we are handling the exceptions in a middleware, there is no need for ANY `re-raising exception` code in our models, controllers and other files. 
    * Application code should just contain the happy path and raise `known errors` if required. Other than that, no exception related code is required in the application code.
* This gem renders a standard JSON error response in case there is any error when calling an API route (`/api`). Currently, if there is any error, an HTML response is returned even if a JSON API route is called.


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'beekeeper'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install beekeeper
```

## Usage

* Include `Beekeeper::Rescuer` in your application controller so that known errors are logged and response is returned in a standard JSON format.
    * These are the `known errors` it rescues:
        * `CustomErrors`
        * `BaseError`
        * `ActiveRecord::RecordInvalid` (Validation errors)
        * `ActiveRecord::RecordNotFound`
        
* This library also inserts a `TrapApiExceptions` middleware in your Rails application stack which traps errors from an API route (`/api`) and returns a standard JSON error response by default. (Without this middleware, an HTML response is returned)

## Usage

* Define `CustomErrors` in this gem and let other Rails apps inherit or use this in their apps.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
