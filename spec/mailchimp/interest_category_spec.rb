# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe MailchimpAPIV3::List::InterestCategory, vcr: { cassette_name: 'mailchimp' } do
  let(:lists) { MailchimpAPIV3.connect.lists }
  let(:list) { lists.first }
  let(:interest_category) { list.interest_categories.first }

  it 'is the expected class' do
    expect(interest_category).to be_a MailchimpAPIV3::List::InterestCategory
  end

  it 'has a title' do
    expect(interest_category.title).to eq 'Colors'
  end

  it 'has an id' do
    expect(interest_category.id).to eq '2ce011eb68'
  end

  it 'has an interests collection' do
    interests = interest_category.interests
    expect(interests).to be_an Array
    expect(interests.sample).to be_a MailchimpAPIV3::List::InterestCategory::Interest
  end
end
