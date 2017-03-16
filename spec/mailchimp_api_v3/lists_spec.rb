# encoding: utf-8
# frozen_string_literal: true
describe Mailchimp::Lists, vcr: { cassette_name: 'lists' } do
  let(:lists) { Mailchimp.connect.lists }

  it 'is the expected class' do
    expect(lists).to be_a Mailchimp::Lists
  end

  it 'has a count' do
    expect(lists.count).to eq 4
  end

  it 'returns a list by id' do
    expect(Mailchimp.connect.lists('aa923b0da6')).to be_a Mailchimp::List
  end

  it 'handles a non-existent id' do
    expect(Mailchimp.connect.lists('beef')).to be_nil
  end
end
