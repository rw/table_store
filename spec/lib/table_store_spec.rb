require 'spec_helper'
require 'lib/table_store'

describe TableStore do
  class Book < Hash; end
  class Author < String; end

  context 'multiple tables referencing each other' do
    Given(:books) { TableStore::Table.new }
    Given(:authors) { TableStore::Table.new }

    context 'with one reference' do
      Given(:book) { Book.new }
      Given(:author) { Author.new('Suess') }
      before { authors[0] = author }
      before { book['author'] = authors[0] }

      Then { book['author'].send(:should) == author }
    end
  end
end
