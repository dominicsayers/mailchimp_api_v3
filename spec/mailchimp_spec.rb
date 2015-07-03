# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe MailchimpAPIV3 do
  it 'does not attempt to connect without an API key in the right format' do
    expect { MailchimpAPIV3.connect '' }.to raise_error { |e|
      expect(e).to be_a MailchimpAPIV3::Exception::APIKeyError
      expect(e.message).to eq 'Invalid API key format: '
    }
  end

  it 'connects with an API key' do
    expect { MailchimpAPIV3.connect }.not_to raise_error
  end
end
