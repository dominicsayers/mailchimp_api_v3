# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::InterestCategories, vcr: { cassette_name: 'mailchimp' } do
  let(:list) { Mailchimp.connect.lists.first }
  let(:interest_categories) { list.interest_categories }

  it 'is the expected class' do
    expect(interest_categories).to be_a Mailchimp::List::InterestCategories
  end

  it 'has a count' do
    expect(interest_categories.count).to eq 2
  end

  it 'finds a matching instance' do
    data = { 'title' => 'Colors' }
    interest_category = interest_categories.find_by data
    expect(interest_category).to be_a Mailchimp::List::InterestCategory
    expect(interest_category.id).to eq '2ce011eb68'
  end

  context 'adding a new instance' do
    context '#create' do
      it 'can add a new instance' do
        data = { 'title' => 'Days', 'type' => 'checkboxes' }
        interest_category = interest_categories.create data
        expect(interest_category).to be_a Mailchimp::List::InterestCategory
        expect(interest_category.title).to eq 'Days'
      end

      it 'fails adding an instance with the same details' do
        data = { 'title' => 'Colors', 'type' => 'checkboxes' }
        expect { interest_categories.create data }.to raise_error Mailchimp::Exception::Duplicate
      end
    end

    context '#first_or_create' do
      it 'finds an instance with the same details' do
        data = { 'title' => 'Colors', 'type' => 'checkboxes' }
        interest_category = interest_categories.first_or_create data
        expect(interest_category).to be_a Mailchimp::List::InterestCategory
        expect(interest_category.title).to eq 'Colors'
      end

      it 'creates a new instance if one does not yet exist' do
        data = { 'title' => 'Sex', 'type' => 'radio' }
        interest_category = interest_categories.first_or_create data
        expect(interest_category).to be_a Mailchimp::List::InterestCategory
        expect(interest_category.title).to eq 'Sex'
      end
    end
  end
end
