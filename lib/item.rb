class Item

  #add checkouts/ins/history with patron name

  attr_reader(:id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_items = DB.exec("SELECT * FROM items;")
    items = []
    returned_items.each() do |item|
      latest_transaction_id = item.fetch('latest_transaction_id')
      id = item.fetch('id').to_i()
      items.push(Item.new({:latest_transaction_id => latest_transaction_id, :id => id}))
    end
    items
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM items WHERE id = #{@id};")
    @latest_transaction_id = result.first().fetch('latest_transaction_id')
    Item.new({:latest_transaction_id => @latest_transaction_id, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO items (latest_transaction_id) VALUES (NULL) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |an_item|
    self.latest_transaction_id().==(an_item.latest_transaction_id()).&(self.id().==(an_item.id()))
  end

  # define_method(:change_name) do |attributes|
  #   @name = attributes.fetch(:name, @name)
  #   @id = self.id()
  #   DB.exec("UPDATE items SET name = '#{@name}' WHERE id = #{@id};")
  # end

  define_method(:delete) do
    DB.exec("DELETE FROM items WHERE id = #{self.id()};")
  end

end
