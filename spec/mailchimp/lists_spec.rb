# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe MailchimpAPIV3::Lists, vcr: { cassette_name: 'mailchimp' } do
  let(:lists) { MailchimpAPIV3.connect.lists }

  it 'is the expected class' do
    expect(lists).to be_a MailchimpAPIV3::Lists
  end

  it 'has a count' do
    expect(lists.count).to eq 1
  end
end
