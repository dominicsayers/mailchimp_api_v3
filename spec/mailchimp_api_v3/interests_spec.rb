# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategory::Interests, vcr: { cassette_name: 'interests' } do
  let(:list) { Mailchimp.connect.lists.first }
  let(:title) { 'Days' }
  let(:interest_category) { list.interest_categories.create 'title' => title, 'type' => 'checkboxes' }
  let(:interests) { interest_category.interests }

  it 'is the expected class' do
    expect(interests).to be_a Mailchimp::List::InterestCategory::Interests
  end

  context 'adding and deleting' do
    context '#create, #find_by, #delete, #first_or_create' do
      it 'can add and delete a new instance' do
        name = 'Monday'
        data = { 'name' => name }

        # #create
        expect { interests.create data }.to change { interest_category.interests.count }.by(1)
        expect { interests.create data }.to raise_error Mailchimp::Exception::Duplicate

        # #find_by
        interest = interest_category.interests.find_by name: name
        expect(interest).to be_a Mailchimp::List::InterestCategory::Interest
        expect(interest.name).to eq name

        # #first_or_create finds the same instance
        interest2 = interest_category.interests.first_or_create name: name
        expect(interest.id).to eq(interest2.id)

        # #delete
        expect { interest.delete }.to change { interest_category.interests.count }.by(-1)

        # #first_or_create creates a new instance
        name = 'Tuesday'
        data = { 'name' => name }
        interest = interests.first_or_create data
        expect(interest.name).to eq name
      end
    end
  end
end
