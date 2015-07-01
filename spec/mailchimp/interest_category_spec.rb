# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::List::InterestCategory, vcr: { cassette_name: 'mailchimp' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }
  let(:interest_category) { list.interest_categories.first }

  it 'is the expected class' do
    expect(interest_category).to be_a Mailchimp::List::InterestCategory
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
    expect(interests.sample).to be_a Mailchimp::List::InterestCategory::Interest
  end

  it 'can add a new interest to the category' do
    expect { interest_category.update name: 'Green' }.to change {
      interest_category.interests.count
    }.from(1).to(2)

    expect { interest_category.update name: 'Green' }.not_to change {
      interest_category.interests.count
    }
  end
end
