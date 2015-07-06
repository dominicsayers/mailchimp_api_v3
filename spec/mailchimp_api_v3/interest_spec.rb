# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategory::Interest, vcr: { cassette_name: 'mailchimp' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }
  let(:title) { 'Days' }
  let(:interest_category) { list.interest_categories.create 'title' => title, 'type' => 'checkboxes' }
  let(:day) { 'Monday' }
  let(:interest) { interest_category.interests.create name: day }

  it 'is the expected class' do
    expect(interest).to be_a Mailchimp::List::InterestCategory::Interest
  end

  it 'has a name' do
    expect(interest.name).to eq name
  end

  it 'deletes an instance' do
    expect { interest.delete }.to change { interest_category.interests.count }.from(1).to(0)
  end
end
