# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp do
  it 'has an API key to work with' do
    expect(api_key?).to be_truthy
  end

  it 'does not connect without a valid API key' do
    expect { Mailchimp.connect '' }.to raise_error RuntimeError
  end

  it 'connects with an API key' do
    expect { Mailchimp.connect }.not_to raise_error
  end
end
