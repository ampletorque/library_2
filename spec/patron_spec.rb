require('helper/spec_helper')

describe(Patron) do

  describe('#name') do
    it('returns the name') do
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      expect(patron_1.name()).to(eq('Grigory Alexandrovich Pechorin'))
    end
  end

  describe('#id') do
    it('returns the id') do
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => 1})
      expect(patron_1.id()).to(eq(1))
    end
  end

  describe('.all') do
    it('initially has no patrons') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('.find') do
    it('returns a patron by its id') do
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      patron_1.save()
      patron_2 = Patron.new({:name => 'Maxim Maxymich', :id => nil})
      patron_2.save()
      expect(Patron.find(patron_2.id())).to(eq(patron_2))
    end
  end

  describe('#==') do
    it('is the same patron if it has the same name and id') do
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      patron_2 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      expect(patron_1).to(eq(patron_2))
    end
  end

  describe('#change_name') do
    it("lets you change a patron name") do
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      patron_1.save()
      patron_1.change_name({:name => 'Maxim Maxymich'})
      expect(patron_1.name()).to(eq('Maxim Maxymich'))
    end
  end

  describe('#delete"') do
    it('lets you delete a patron') do
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      patron_1.save()
      patron_2 = Patron.new({:name => 'Maxim Maxymich', :id => nil})
      patron_2.save()
      patron_1.delete()
      expect(Patron.all()).to(eq([patron_2]))
    end
  end

  describe('#checkouts') do
    it('gives a full checkout history for a patron') do
    end

    it('shows overdue items for a patron') do
    end

    it('shows overdue items for all patrons') do
    end

    it('shows due dates for checked-out items for a patron') do
    end
  end

end
