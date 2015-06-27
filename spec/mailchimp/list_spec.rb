# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::List, vcr: { cassette_name: 'list' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }

  it 'is the expected class' do
    expect(list).to be_a Mailchimp::List
  end

  it 'has a name' do
    expect(list.name).to eq 'My first list'
  end

  it 'has an id' do
    expect(list.id).to eq 'e73f5910ca'
  end
end
