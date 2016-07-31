# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::Exception::APIKeyError, vcr: { cassette_name: 'exception' } do
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
    expect { account.blarbleferry }.to raise_error NoMethodError
  end
end

describe Mailchimp::Exception::BadRequest do
  it 'raises a Duplicate exception if the message says so' do
    data = { 'detail' => 'The thing already exists, idiot' }
    expect { Mailchimp::Exception.parse_invalid_resource_exception data }
      .to raise_error Mailchimp::Exception::Duplicate
  end

  it 'raises a MissingField exception if the message says so' do
    data = { 'detail' => 'The thing can\'t be blank, idiot' }
    expect { Mailchimp::Exception.parse_invalid_resource_exception data }
      .to raise_error Mailchimp::Exception::MissingField
  end

  it 'raises a BadRequest exception otherwise' do
    data = { 'detail' => 'The thing is an idiot' }
    expect { Mailchimp::Exception.parse_invalid_resource_exception data }
      .to raise_error Mailchimp::Exception::BadRequest
  end

  it 'responds to everything' do
    expect(Mailchimp::Exception::BadRequest.new('xxx').respond_to?(:zzz)).to be_truthy
  end
end
