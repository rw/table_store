require 'spec_helper'
require 'lib/table_store/table'

describe TableStore::Table do
  Given(:klazz) { TableStore::Table }
  Given(:table) { klazz.new }

  context 'before first insertion' do
    Then { table.empty?.should be_true }
  end

  context 'inserting first element' do
    Given { table[0] = :foo }
    Then { table.keys.should == [0] }
    Then { table.empty?.should be_false }
  end

  context 'inserting many elements' do
    Given { table[0] = :foo }
    Given { table[1] = :bar }

    Then { table.keys.should == [0, 1] }

    Given { table[0].send(:should) == :foo }
    Given { table[1].send(:should) == :bar }

    Then { table.empty?.should be_false }
  end

  context 'out of order insertion' do
    Given { table[1] = :one }
    Given { table[0] = :zero }

    Then { table.keys.should == [0, 1] }
  end

  describe 'lazy relational evaluation' do
    Given(:parent_key) { 0 }
    Given(:parent)     { {:child => table[1]} }
    Given(:child_key)  { 1 }
    Given(:child)      { Object.new }

    before { table[parent_key] = parent }

    it 'gets current value at the reference' do
      table[parent_key][:child].send(:should) == nil

      table[child_key] = child

      table[parent_key][:child].send(:should) == child
    end
  end
end
