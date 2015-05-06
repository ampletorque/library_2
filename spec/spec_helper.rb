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
    DB.exec("DELTE FROM titles *;")
    DB.exec("DELTE FROM authors *;")
    DB.exec("DELTE FROM items *;")
    DB.exec("DELTE FROM transactions *;")
    DB.exec("DELTE FROM patrons *;")
  end
end
