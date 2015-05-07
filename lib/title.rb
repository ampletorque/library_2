class Title

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
#    @id = attributes.fetch(:id)
#    self.save
    result = DB.exec("INSERT INTO titles (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()

  end

  define_singleton_method(:all) do
    returned_titles = DB.exec("SELECT * FROM titles;")
    titles = []
    returned_titles.each() do |title|
      name = title.fetch('name')
      id = title.fetch('id').to_i()
      titles.push(Title.new({:name => name, :id => id}))
    end
    titles
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM titles WHERE id = #{@id};")
    @name = result.first().fetch('name')
    Title.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO titles (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |a_title|
    self.name().==(a_title.name()).&(self.id().==(a_title.id()))
  end

  define_method(:change_name) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE titles SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM titles WHERE id = #{self.id()};")
  end

  define_method(:add_author) do |author_id|
    DB.exec("INSERT INTO authors_titles (author_id, title_id) VALUES (#{@author_id}, #{@self_id})")
  end

end
