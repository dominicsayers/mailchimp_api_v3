# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::Client, vcr: { cassette_name: 'client' } do
  context 'unauthorized API key' do
    let(:bad_key) { 'xxxxxxxxxx-us11' }

    it 'raises an exception if we try to get data' do
      expect { Mailchimp.connect(bad_key).account }.to raise_error Mailchimp::APIKeyError
    end

    it 'says it is not connected' do
      expect(Mailchimp.connect(bad_key).connected?).to be_falsey
    end
  end

  context 'valid API key' do
    it 'says it is connected' do
      expect(Mailchimp.connect.connected?).to be_truthy
    end

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
end
