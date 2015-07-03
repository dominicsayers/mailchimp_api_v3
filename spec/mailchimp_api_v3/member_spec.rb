# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::Member, vcr: { cassette_name: 'mailchimp' } do
  let(:lists) { Mailchimp.connect.lists }
  let(:list) { lists.first }
  let(:member) { list.members.first }

  it 'is the expected class' do
    expect(member).to be_a Mailchimp::List::Member
  end

  it 'has a name' do
    expect(member.name).to eq 'Ann Example'
  end

  it 'has an id' do
    expect(member.id).to eq '140b91c107d2058dee730e75be0b1151'
  end

  context 'updates name fields correctly' do
    it 'uses friendly name fields' do
      updated_member = member.update name: 'Billy Bonkers'
      expect(updated_member).to be_a Mailchimp::List::Member
      expect(updated_member).to have_attributes name: 'Billy Bonkers'

      updated_member = updated_member.update first_name: 'William'
      expect(updated_member).to have_attributes name: 'William Bonkers'
    end

    it 'handles multiple definitions of the same field' do
      data = {
        name: 'Billy Bonkers',
        first_name: 'William',
        merge_fields: {
          FNAME: 'Ann',
          LNAME: 'Example'
        }
      }

      expect(member.update data).to have_attributes name: 'Ann Example'
    end
  end
end
