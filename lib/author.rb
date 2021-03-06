class Author

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i()
      authors.push(Author.new({:name => name, :id => id}))
    end
    authors
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM authors WHERE id = #{@id};")
    @name = result.first().fetch('name')
    Author.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO authors (NAME) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |an_author|
    self.name().==(an_author.name()).&(self.id().==(an_author.id()))
  end

  define_method(:change_name) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM authors WHERE id = #{self.id()};")
  end

  define_method(:add_title) do |title_id|
    DB.exec("INSERT INTO authors_titles (author_id, title_id) VALUES (#{self.id}, #{@title_id})")
  end

end
