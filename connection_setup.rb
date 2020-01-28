# frozen_string_literal: true

require 'sequel'
require 'pg'

DB = if ENV['ENVIRONMENT'] == 'test'
       Sequel.connect('postgres://localhost/bnb_test')
     else
       Sequel.connect('postgres://localhost/bnb')
     end
