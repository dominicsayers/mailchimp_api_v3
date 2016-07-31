# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::Client, vcr: { cassette_name: 'client' } do
  context 'unauthorized API key' do
    let(:bad_key) { 'xxxxxxxxxx-us11' }

    it 'raises an exception if we try to get data' do
      expect { Mailchimp::Client.new(bad_key).account }.to raise_error Mailchimp::Exception::APIKeyError
    end

    it 'says it is not connected' do
      expect(Mailchimp::Client.new(bad_key).connected?).to be_falsey
    end
  end

  context 'valid API key' do
    it 'says it is connected' do
      expect(Mailchimp::Client.new.connected?).to be_truthy
    end

    it 'is the expected class' do
      expect(Mailchimp::Client.new).to be_a Mailchimp::Client
    end

    it 'has an account method' do
      expect(Mailchimp::Client.new.account).to be_a Mailchimp::Account
    end

    it 'has a lists collection' do
      lists = Mailchimp::Client.new.lists
      expect(lists).to be_an Array
      expect(lists.sample).to be_a Mailchimp::List
    end

    it 'retrieves a list by name' do
      list = Mailchimp::Client.new.lists 'My first list'
      expect(list).to be_a Mailchimp::List
      expect(list.name).to eq 'My first list'
    end

    it "doesn't respond to everything" do
      expect(Mailchimp::Client.new.respond_to?(:zzz)).to be_falsey
    end
  end

  context 'exceptions' do
    let(:client) { Mailchimp::Client.new }

    context 'problems we can retry the request for' do
      it 'eventually raises the exception' do
        allow(client).to receive(:remote_no_payload).and_raise SocketError.new('test message')

        expect { client.account }.to raise_error { |e|
          expect(e).to be_a(SocketError)
          expect(e.message).to eq('test message')
        }
      end

      it 'only raises the exception after several retries' do
        allow(client).to receive(:remote_no_payload).twice.and_raise SocketError.new('test message')
        allow(client).to receive(:remote_no_payload).and_return '"id":1'
        expect { client.account }.not_to raise_error
      end
    end

    context 'unexpected error' do
      it 'raises an exception if it encounters an unexpected error' do
        exception = NotImplementedError.new('test message')

        expect { client.__send__(:managed_remote_exception, exception) }.to raise_error { |e|
          expect(e).to be_a(NotImplementedError)
          expect(e.message).to eq('test message')
        }
      end
    end
  end
end
