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

  describe('#overdue') do
    it('shows overdue items for a patron') do
      #returns array of item ids - all overdue
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      patron_1.save()
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      author_1.save()
      author_2 = Author.new({:name => 'Pushkin', :id => nil})
      author_2.save()
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      title_1.save()
      title_2 = Title.new({:name => 'Evgeny Onegin', :id => nil})
      title_2.save()
      title_1.add_author(Author.find(author_1.id()))
      title_2.add_author(Author.find(author_2.id()))
      item_1 = title_1.add_copy(Title.find(title_1.id()))
      item_2 = title_2.add_copy(Title.find(title_2.id()))
      transaction_1 = patron_1.check_out(current_date, auto_due_date)
      transaction_2 = patron_1.check_out(current_date, auto_due_date)
      expect(patron.checkouts(Patron.find(patron_1.id()))).to(eq())
    end

    it('shows overdue items for all patrons') do
      #returns array of item ids - all overdue
      patron_1 = Patron.new({:name => 'Grigory Alexandrovich Pechorin', :id => nil})
      patron_1.save()
      patron_2 = Patron.new({:name => 'Maxim Maxymich', :id => nil})
      patron_2.save()
      author_1 = Author.new({:name => 'Lermontov', :id => nil})
      author_1.save()
      author_2 = Author.new({:name => 'Pushkin', :id => nil})
      author_2.save()
      title_1 = Title.new({:name => 'A Hero of Our Time', :id => nil})
      title_1.save()
      title_2 = Title.new({:name => 'Evgeny Onegin', :id => nil})
      title_2.save()
      title_1.add_author(Author.find(author_1.id()))
      title_2.add_author(Author.find(author_2.id()))
      item_1 = title_1.add_copy(Title.find(title_1.id()))
      item_2 = title_2.add_copy(Title.find(title_2.id()))
      transaction_1 = patron_1.check_out(current_date, auto_due_date)
      transaction_2 = patron_2.check_out(current_date, auto_due_date)
      expect(patron.checkouts(nil)).to(eq())
    end
    #
    # it('shows due dates for checked-out items for a patron') do
    #   #returns array of item ids - all checked out
    #   expect(patron.checkouts(Patron.find(patron_1.id()), all))
    # end
  end

  describe('#checkout_history') do
    it('gives a full checkout history for a person') do
      #returns array of transaction ids - all transactions
    end
  end

end
