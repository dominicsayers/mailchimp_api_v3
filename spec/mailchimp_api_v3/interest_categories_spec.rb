# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategories, vcr: { cassette_name: 'mailchimp' } do
  let(:list) { Mailchimp.connect.lists.first }
  let(:interest_categories) { list.interest_categories }

  it 'is the expected class' do
    expect(interest_categories).to be_a Mailchimp::List::InterestCategories
  end

  context 'adding and deleting' do
    context '#create, #find_by, #delete' do
      it 'can add and delete a new instance' do
        title = 'Days'
        data = { 'title' => title, 'type' => 'checkboxes' }

        # #create
        expect { interest_categories.create data }.to change { list.interest_categories.count }.by(1)
        expect { interest_categories.create data }.to raise_error Mailchimp::Exception::Duplicate

        # #find_by
        interest_category = list.interest_categories.find_by title: title
        expect(interest_category).to be_a Mailchimp::List::InterestCategory
        expect(interest_category.title).to eq title

        # #first_or_create finds the same instance
        interest_category2 = list.interest_categories.first_or_create title: title
        expect(interest_category.id).to eq(interest_category2.id)

        # #delete
        expect { interest_category.delete }.to change { list.interest_categories.count }.by(-1)
      end
    end

    context '#first_or_create createsa new instance' do
      it 'creates a new instance if one does not yet exist' do
        data = { 'title' => 'Sex', 'type' => 'radio' }
        interest_category = interest_categories.first_or_create data
        expect(interest_category).to be_a Mailchimp::List::InterestCategory
        expect(interest_category.title).to eq 'Sex'
      end
    end
  end
end
