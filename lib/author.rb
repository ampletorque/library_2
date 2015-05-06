class Author

  attr_reader(:name, :id)

  define_method(:initalize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton(method(:all)) do
    returned_authors = DB.exec('SELECT * FROM authors;')
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
    result = DB.exec('SELECT * FROM authors WHERE id = #{@id};')
    @name = result.first().fetch('name')
    Author.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec('INSERT INTO authors (NAME) VALUES ("#{@name}") RETURNING id;')
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |an_author|
    
  end
