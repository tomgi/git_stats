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
  end
end