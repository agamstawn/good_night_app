# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

ruby 3.2.0

rails 8

* System dependencies

* Configuration
please adjust your database.yml with your credential db

* Database creation

run "rails db:create"
run "rails db:migrate"
run "rails db:seed"

* Database initialization

* How to run the test suite

to test sleep_records and follows controller, please run :

"bundle exec rspec spec/controllers/api/v1/sleep_records_controller_spec.rb"
"bundle exec rspec spec/controllers/api/v1/follows_controller_spec.rb"

and for test request, please run

bundle exec rspec spec/requests/api/v1/sleep_records_spec.rb

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
