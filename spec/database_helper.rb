# frozen_string_literal: true

require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'bnb_test')
  connection.exec('TRUNCATE users, places;')
end
