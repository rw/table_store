require 'spec_helper'
require 'lib/table_store/table'

describe TableStore::Table do
  Given(:klazz) { TableStore::Table }
  Given(:instance) { klazz.new }

  describe '#insert' do
    context 'before first insertion' do
      Then { instance.empty?.should be_true }
    end

    context 'inserting first element' do
      Given { instance.insert 0, :foo }
      Then { instance.indices.should == [0] }
      Then { instance.empty?.should be_false }
    end

    context 'inserting many elements' do
      Given { instance.insert 0, :foo }
      Given { instance.insert 1, :bar }
      Then { instance.indices.should include(0) }
      Then { instance.indices.should include(1) }
      Then { instance.empty?.should be_false }
    end

    context 'duplicate keys' do
      before { instance.insert 1, :baz }
      Then do
        expect{instance.insert(1, :foo)}.to raise_error(klazz::DuplicateKeyError)
      end
    end
  end

  describe '#ref' do
    Given(:ref) { instance.ref key }

    context 'with no values in the table' do
      Given(:key) { 0 }
      Then { ref.fetch.should be_nil }
    end

    context 'with no values in the table' do
      before { instance.insert(0, :a) }
      Given(:key) { 0 }
      Then { ref.to_sym.should == :a }
      Then { ref.to_sym.should == :a }
    end

    context 'with many values in the table' do
      before { instance.insert(0, :a) }
      before { instance.insert(1, :b) }
      Given(:key) { 1 }
      Then { ref.to_sym.should == :b }
    end
  end
end
