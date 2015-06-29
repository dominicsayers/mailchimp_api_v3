# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp do
  it 'has an API key to work with' do
    expect(api_key?).to be_truthy
  end

  it 'does not attempt to connect without an API key in the right format' do
    expect { Mailchimp.connect '' }.to raise_error { |e|
      expect(e).to be_a Mailchimp::APIKeyError
      expect(e.message).to eq 'Invalid API key format'
    }
  end

  it 'connects with an API key' do
    expect { Mailchimp.connect }.not_to raise_error
  end
end