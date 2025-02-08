# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

ruby 3.2.0

rails 8.0.1

* Configuration

run "bundle install"

please adjust your database.yml with your local credential db

* Database creation and initialization

run "rails db:create"

run "rails db:migrate"

run "rails db:seed"

* How to run the test suite

to test sleep_records and follows controller, please run :

"bundle exec rspec spec/controllers/api/v1/sleep_records_controller_spec.rb"
"bundle exec rspec spec/controllers/api/v1/follows_controller_spec.rb"

and for test request, please run

"bundle exec rspec spec/requests/api/v1/sleep_records_spec.rb"

Import Good night.postman_collection.json to your postman if you want to try to test via postman

run "rails s"

try to test Good night collection requests from postman

* ...
