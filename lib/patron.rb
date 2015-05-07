class Patron

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
#    @id = attributes.fetch(:id)
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
#    self.save
  end

  define_singleton_method(:all) do
    returned_patron = DB.exec("SELECT * FROM patrons;")
    patron = []
    returned_patron.each() do |item|
      name = item.fetch('name')
      id = item.fetch('id').to_i()
      patron.push(Patron.new({:name => name, :id => id}))
    end
    patron
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM patrons WHERE id = #{@id};")
    @name = result.first().fetch('name')
    Patron.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |an_item|
    self.name().==(an_item.name()).&(self.id().==(an_item.id()))
  end

  define_method(:change_name) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end


  define_method(:check_out) do |item_id, due_days|
    due_date = Time.new.to_date + due_days
    Transaction.new({:in_out => false, :patron_id => self.id, :item_id => item_id, :time => Time.new.to_date, :due => due_date, :id => nil})
    Transaction.save()
  end

  define_method(:check_in) do |item_id|
    Transaction.new({:in_out => true, :patron_id => self.id, :item_id => item_id, :time => Time.new.to_date, :due => nil, :id => nil})
    Transaction.save()
  end

  define_method(:items_out) do

  end


  define_method(:checkout_history) do
  end

end
