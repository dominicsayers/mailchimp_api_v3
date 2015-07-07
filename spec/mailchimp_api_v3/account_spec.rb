# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::Account, vcr: { cassette_name: 'account' } do
  it 'is the expected class' do
    expect(Mailchimp.connect.account).to be_a Mailchimp::Account
  end

  it 'has a name' do
    expect(Mailchimp.connect.account.name).to eq 'InSite Arts'
  end

  it 'has an id' do
    expect(Mailchimp.connect.account.id).to eq '1dbca289fd41b54838bcbb501'
  end
end
