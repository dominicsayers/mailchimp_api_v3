# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::List::InterestCategory::Interests, vcr: { cassette_name: 'mailchimp' } do
  let(:list) { Mailchimp.connect.lists.first }
  let(:interest_category) { list.interest_categories.first }
  let(:interests) { interest_category.interests }

  it 'is the expected class' do
    expect(interests).to be_a Mailchimp::List::InterestCategory::Interests
  end

  it 'has a count' do
    expect(interests.count).to eq 1
  end
end
