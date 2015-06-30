# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::Exception::APIKeyError, vcr: { cassette_name: 'mailchimp' } do
  let(:bad_key) { 'xxxxxxxxxx-us11' }

  it 'raises an exception if the API key is not valid' do
    expect { Mailchimp.connect(bad_key).account }.to raise_error { |e|
      expect(e).to be_a Mailchimp::Exception::APIKeyError
      expect(e.type).to eq 'http://kb.mailchimp.com/api/error-docs/401-api-key-invalid'
      expect(e.title).to eq 'API Key Invalid'
      expect(e.status).to eq 401
      expect(e.detail).to eq 'Your API key may be invalid, or you\'ve attempted to access the wrong datacenter.'
    }
  end

  it 'does not raise an exception if the API key is valid' do
    expect { Mailchimp.connect.account }.not_to raise_error
  end
end

describe Mailchimp::Exception::UnknownAttribute, vcr: { cassette_name: 'mailchimp' } do
  let(:account) { Mailchimp.connect.account }

  it 'returns a known attribute' do
    expect { account.name }.not_to raise_error
  end

  it 'fails if we ask for an unknown attribute' do
    expect { account.blarbleferry }.to raise_error Mailchimp::Exception::UnknownAttribute
  end
end

describe Mailchimp::Exception::MissingId, vcr: { cassette_name: 'mailchimp' } do
  let(:account) { Mailchimp.connect.account }

  it 'accepts data with an id' do
    expect { account.fail_unless_id_in 'id' => 1 }.not_to raise_error
  end

  it 'fails if we supply data without an id' do
    expect { account.fail_unless_id_in 'name' => 'Terry' }.to raise_error Mailchimp::Exception::MissingId
  end
end
