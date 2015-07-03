# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp do
  it 'does not attempt to connect without an API key in the right format' do
    expect { Mailchimp.connect '' }.to raise_error { |e|
      expect(e).to be_a Mailchimp::Exception::APIKeyError
      expect(e.message).to eq 'Invalid API key format: '
    }
  end

  it 'connects with an API key' do
    expect { Mailchimp.connect }.not_to raise_error
  end
end
