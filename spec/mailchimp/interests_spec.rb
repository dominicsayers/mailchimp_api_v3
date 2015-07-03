# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe MailchimpAPIV3::List::InterestCategory::Interests, vcr: { cassette_name: 'mailchimp' } do
  let(:list) { MailchimpAPIV3.connect.lists.first }
  let(:interest_category) { list.interest_categories.first }
  let(:interests) { interest_category.interests }

  it 'is the expected class' do
    expect(interests).to be_a MailchimpAPIV3::List::InterestCategory::Interests
  end

  it 'has a count' do
    expect(interests.count).to eq 1
  end

  context 'adding a new instance' do
    context '#create' do
      it 'can add a new instance' do
        data = { 'name' => 'Green' }
        interest = interests.create data
        expect(interest).to be_a MailchimpAPIV3::List::InterestCategory::Interest
        expect(interest.name).to eq 'Green'
      end

      it 'fails adding an instance with the same details' do
        data = { 'name' => 'Red' }
        expect { interests.create data }.to raise_error MailchimpAPIV3::Exception::Duplicate
      end
    end

    context '#first_or_create' do
      it 'finds an instance with the same details' do
        data = { 'name' => 'Red' }
        interest = interests.first_or_create data
        expect(interest).to be_a MailchimpAPIV3::List::InterestCategory::Interest
        expect(interest.name).to eq 'red' # Note case
      end

      it 'creates a new instance if one does not yet exist' do
        data = { 'name' => 'Amber' }
        interest = interests.first_or_create data
        expect(interest).to be_a MailchimpAPIV3::List::InterestCategory::Interest
        expect(interest.name).to eq 'Amber'
      end
    end
  end
end
