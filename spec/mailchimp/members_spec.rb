# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::List::Members, vcr: { cassette_name: 'members' } do
  let(:list) { Mailchimp.connect.lists.first }
  let(:members) { list.members }

  it 'is the expected class' do
    expect(members).to be_a Mailchimp::List::Members
  end

  it 'has a count' do
    expect(members.count).to eq 2
  end
end
