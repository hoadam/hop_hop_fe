# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## How to regenerate openapi client
1. Clone/pull latest openapi spec under hophop_be
2. Run `openapi-generator generate -i <path to swagger.yaml> -g ruby -o ./vendor/gems/hophop-be --additional-properties=library=faraday,gemName=hophop-be-api`
3. Run `bundle install`
4. Refer to README.md under /vendor/gems/hophop-be for usage instructions
NOTE: if run into issue installing ruby-magic, run `brew install libmagic`

## How to re-record VCR cassettes
1. On backend project:
    1. Run `RAILS_ENV=test rails db:drop db:create db:migrate` to reset test database
    2. Run `RAILS_ENV=test rails s` to start test server
2. On frontend project:
    1. Run `bundle exec rspec spec`
    2. Commit new cassettes
