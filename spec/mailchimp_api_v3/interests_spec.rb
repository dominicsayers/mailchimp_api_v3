# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategory::Interests, vcr: { cassette_name: 'mailchimp' } do
  let(:list) { Mailchimp.connect.lists.first }
  let(:title) { 'Days' }
  let(:interest_category) { list.interest_categories.create 'title' => title, 'type' => 'checkboxes' }
  let(:interests) { interest_category.interests }

  it 'is the expected class' do
    expect(interests).to be_a Mailchimp::List::InterestCategory::Interests
  end

  it 'has a count' do
    expect(interests.count).to eq 1
  end

  context 'adding a new instance' do
    context '#create' do
      it 'can add a new instance' do
        day = 'Monday'
        interest = interests.create name: day
        expect(interest).to be_a Mailchimp::List::InterestCategory::Interest
        expect(interest.name).to eq day
        expect { interests.create name: day }.to raise_error Mailchimp::Exception::Duplicate

        interest = interests.first_or_create name: day
        expect(interest).to be_a Mailchimp::List::InterestCategory::Interest
        expect(interest.name).to eq day
      end

      it 'creates a new instance if one does not yet exist' do
        data = { 'name' => 'Tuesday' }
        interest = interests.first_or_create data
        expect(interest).to be_a Mailchimp::List::InterestCategory::Interest
        expect(interest.name).to eq 'Tuesday'
      end
    end
  end
end
