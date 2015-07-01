# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::Lists, vcr: { cassette_name: 'mailchimp' } do
  let(:lists) { Mailchimp.connect.lists }

  it 'is the expected class' do
    expect(lists).to be_a Mailchimp::Lists
  end

  it 'has a count' do
    expect(lists.count).to eq 1
  end
end
