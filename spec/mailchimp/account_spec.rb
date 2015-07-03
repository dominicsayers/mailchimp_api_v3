# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe MailchimpAPIV3::Account, vcr: { cassette_name: 'mailchimp' } do
  it 'is the expected class' do
    expect(MailchimpAPIV3.connect.account).to be_a MailchimpAPIV3::Account
  end

  it 'has a name' do
    expect(MailchimpAPIV3.connect.account.name).to eq 'InSite Arts'
  end

  it 'has an id' do
    expect(MailchimpAPIV3.connect.account.id).to eq '1dbca289fd41b54838bcbb501'
  end
end
