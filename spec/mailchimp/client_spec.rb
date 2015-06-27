# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::Client, vcr: { cassette_name: 'client' } do
  it 'is the expected class' do
    expect(Mailchimp.connect).to be_a Mailchimp::Client
  end

  it 'has an account method' do
    expect(Mailchimp.connect.account).to be_a Mailchimp::Account
  end

  it 'has a lists collection' do
    lists = Mailchimp.connect.lists
    expect(lists).to be_an Array
    expect(lists.sample).to be_a Mailchimp::List
  end
end
