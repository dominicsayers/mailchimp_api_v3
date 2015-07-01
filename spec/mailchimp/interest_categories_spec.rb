# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::List::InterestCategories, vcr: { cassette_name: 'mailchimp' } do
  let(:list) { Mailchimp.connect.lists.first }
  let(:interest_categories) { list.interest_categories }

  it 'is the expected class' do
    expect(interest_categories).to be_a Mailchimp::List::InterestCategories
  end

  it 'has a count' do
    expect(interest_categories.count).to eq 1
  end
end
