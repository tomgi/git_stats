# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Hash do
  context 'to_key_indexed_array' do
    it 'should convert hash to array using keys as indexes' do
      hash = {1 => 'x', 2 => 1, 5 => 'a'}
      hash.to_key_indexed_array.should == [nil, 'x', 1, nil, nil, 'a']
    end

    it 'should throw exception if not all of the keys are numbers' do
      hash = {1 => 'x', 'b' => 2}
      expect { hash.to_key_indexed_array }.to raise_error(ArgumentError)
    end

    context 'should take optional min_size and default parameters' do
      let(:hash) { {1 => 'x', 2 => 1, 5 => 'a'} }
      it 'should fill array with defaults up to min_size' do
        hash.to_key_indexed_array(min_size: 8, default: 0).should == [0, 'x', 1, 0, 0, 'a', 0, 0]
      end
      it 'should use default value where key is not in hash' do
        hash.to_key_indexed_array(min_size: 2, default: 0).should == [0, 'x', 1, 0, 0, 'a']
      end
    end
  end
end
