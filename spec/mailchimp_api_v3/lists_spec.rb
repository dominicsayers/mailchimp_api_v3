# encoding: utf-8
describe Mailchimp::Lists, vcr: { cassette_name: 'lists' } do
  let(:lists) { Mailchimp.connect.lists }

  it 'is the expected class' do
    expect(lists).to be_a Mailchimp::Lists
  end

  it 'has a count' do
    expect(lists.count).to eq 4
  end
end
