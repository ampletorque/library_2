require('spec_helper')


describe(Author) do

  describe('#name') do
    it('returns the name') do
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      expect(author_1.name()).to(eq('Lermontov'))
    end
  end

  describe('#id') do
    it('returns author id') do
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      expect(author_1.name()).to(eq('Lermontov'))
    end
  end

  describe('.all') do
    it('initially has no authors') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('.find') do
    it('returns an author by its id') do
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      author_1.save()
      author_2 = Author.new({:name => 'Pushkin', :id => nil})
      author_2.save()
      expect(Author.find(author_2.id())).to(eq(author_2))
    end
  end

  describe('#==') do
    it('is the same author if it has the same name and id') do
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      author_2 = Author.new({:name => 'Lermontov', :id => nil})
      expect(author_1).to(eq(author_2))
    end
  end

  describe('#change_name') do
    it('lets you change an author name') do
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      author_1.save()
      author.update({:name => 'Lermontov'})
    end
  end

  describe('#delete') do
    it('lets you delete an author name') do
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      author_1.save()
      author_2 = Author.new({:name => 'Pushkin', :id => nil})
      author_2.save()
      author_1.delete()
      expect(Author.all()).to(eq(author_2))
    end
  end

end
