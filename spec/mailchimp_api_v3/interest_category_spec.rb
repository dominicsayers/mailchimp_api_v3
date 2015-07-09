# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategory, vcr: { cassette_name: 'interest_category' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }
  let(:title) { 'Days' }
  let(:interest_category) { list.interest_categories.create 'title' => title, 'type' => 'checkboxes' }

  it 'is the expected class' do
    expect(interest_category).to be_a Mailchimp::List::InterestCategory
  end

  it 'has a title' do
    expect(interest_category.title).to eq title
  end

  it 'has an interests collection' do
    expect(interest_category.interests.count).to eq 0
    interest_category.interests.create name: 'Monday'
    interest_category.interests.create name: 'Tuesday'
    interests = interest_category.interests
    expect(interests).to be_an Array
    expect(interests.sample).to be_a Mailchimp::List::InterestCategory::Interest
  end
end
