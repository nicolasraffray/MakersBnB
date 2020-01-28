require 'sequel'
require 'pg'
if ENV["ENVIRONMENT"] == "test"
  DB = Sequel.connect('postgres://localhost/bnb_test')
else 
  DB = Sequel.connect('postgres://localhost/bnb')
end 
