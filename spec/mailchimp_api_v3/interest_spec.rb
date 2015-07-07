# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategory::Interest, vcr: { cassette_name: 'interest' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }
  let(:title) { 'Days' }
  let(:interest_category) { list.interest_categories.create 'title' => title, 'type' => 'checkboxes' }
  let(:name) { 'Monday' }
  let(:interest) { interest_category.interests.create name: name }

  it 'is the expected class' do
    expect(interest).to be_a Mailchimp::List::InterestCategory::Interest
  end

  it 'has a name' do
    expect(interest.name).to eq name
  end

  it 'deletes an instance' do
    interest2 = interest_category.interests.create name: 'Tuesday'
    expect { interest2.delete }.to change { interest_category.interests.count }.by(-1)
  end
end
