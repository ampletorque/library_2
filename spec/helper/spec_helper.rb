require "rspec"
require "pg"

require "title"
require "patron"
require "item"
require "transaction"
require "author"

DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM titles *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM items *;")
    DB.exec("DELETE FROM transactions *;")
    DB.exec("DELETE FROM patrons *;")
  end
end
