# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ByFieldFinder do
  let(:sut) { [double(field1: 'aa', field2: 'bb'), double(field1: 'cc', field2: 'bb'), double(field1: 'aa', field2: 'dd')].extend(ByFieldFinder) }

  [
      {field: :field1, search_value: 'aa', matching_index: 0},
      {field: :field1, search_value: 'cc', matching_index: 1},
      {field: :field2, search_value: 'bb', matching_index: 0},
      {field: :field2, search_value: 'dd', matching_index: 2},
  ].each do |test_params|
    it 'should return first matching object' do
      sut.send("by_#{test_params[:field]}", test_params[:search_value]).should == sut[test_params[:matching_index]]
    end
  end

  it 'should return nil if no object matches' do
    sut.by_field1('xx').should == nil
  end

  it 'should throw exception if elements doesnt respond to given field' do
    expect { sut.by_non_existing_field }.to raise_error
  end
end
