# encoding: utf-8
require 'spec_helper'
require 'mailchimp'

describe Mailchimp::List::Member, vcr: { cassette_name: 'member' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }
  let(:member) { list.members.first }

  it 'is the expected class' do
    expect(member).to be_a Mailchimp::List::Member
  end

  it 'has a name' do
    expect(member.name).to eq 'My first member'
  end

  it 'has an id' do
    expect(member.id).to eq '140b91c107d2058dee730e75be0b1151'
  end
end
