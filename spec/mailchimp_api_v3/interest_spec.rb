# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategory::Interest, vcr: { cassette_name: 'mailchimp' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }
  let(:interest_category) { list.interest_categories.first }
  let(:interest) { interest_category.interests.first }

  it 'is the expected class' do
    expect(interest).to be_a Mailchimp::List::InterestCategory::Interest
  end

  it 'has a name' do
    expect(interest.name).to eq 'red'
  end

  it 'has an id' do
    expect(interest.id).to eq '3fbb48c043'
  end
end
