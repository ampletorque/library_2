require('helper/spec_helper')

describe(Title) do

  describe('#name') do
    it('returns the name') do
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      expect(title_1.name()).to(eq('A Hero of Our Time'))
    end
  end

  describe('#id') do
    it('returns the id') do
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => 1})
      expect(title_1.id()).to(eq(1))
    end
  end

  describe('.all') do
    it('initially has no titles') do
      expect(Title.all()).to(eq([]))
    end
  end

  describe('.find') do
    it('returns a title by its id') do
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      title_1.save()
      title_2 = Title.new({:name => 'Demon', :id => nil})
      title_2.save()
      expect(Title.find(title_2.id())).to(eq(title_2))
    end
  end

  describe('#==') do
    it('is the same title if it has the same name and id') do
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      title_2 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      expect(title_1).to(eq(title_2))
    end
  end

  describe('#change_name') do
    it("lets you change a title name") do
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      title_1.save()
      title_1.change_name({:name => 'Demon'})
      expect(title_1.name()).to(eq('Demon'))
    end
  end

  describe('#delete"') do
    it('lets you delete a title') do
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      title_1.save()
      title_2 = Title.new({:name => 'Demon', :id => nil})
      title_2.save()
      title_1.delete()
      expect(Title.all()).to(eq([title_2]))
    end
  end

end
