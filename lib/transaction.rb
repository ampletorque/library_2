class Transaction

  attr_reader(:id)

  define_method(:initialize) do |attributes|
    @in_out = attributes.fetch(:in_out)
    @patron_id = attributes.fetch(:patron)
    @item_id = attributes.fetch(:item)
    @time = attributes.fetch(:time)
    @due = attributes.fetch(:due)
#    @id = attributes.fetch(:id)
#    self.save
result = DB.exec("INSERT INTO transactions (in_out, time, due) VALUES (#{@in_out}, #{@time}, #{@due}) RETURNING id;")
    @id = result.first.fetch('id').to_i
    DB.exec("INSERT INTO items_transactions (item_id, transaction_id) VALUES (#{@item_id}, #{@id});")
    DB.exec("INSERT INTO items_patrons (item_id, patron_id) VALUES (#{@item_id},#{@patron_id});")
    DB.exec("INSERT INTO patrons_transactions (patron_id, transaction_id) VALUES (#{@patron_id},#{@id});")

  end

  define_method(:save) do
    result = DB.exec("INSERT INTO transactions (in_out, time, due) VALUES (#{@in_out}, #{@time}, #{@due}) RETURNING id;")
    @id = result.first.fetch('id').to_i
    DB.exec("INSERT INTO items_transactions (item_id, transaction_id) VALUES (#{@item_id}, #{@id});")
    DB.exec("INSERT INTO items_patrons (item_id, patron_id) VALUES (#{@item_id},#{@patron_id});")
    DB.exec("INSERT INTO patrons_transactions (patron_id, transaction_id) VALUES (#{@patron_id},#{@id});")
  end

end
