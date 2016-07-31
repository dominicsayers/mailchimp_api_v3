# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::Members do
  context 'paging', vcr: { cassette_name: 'members_paging', allow_playback_repeats: true } do
    let(:page_size) { 10 }
    let(:member_count) { 37 }
    let(:list) { Mailchimp.connect.lists.first }
    let(:members) { list.members 'page_size' => page_size }

    it 'is the expected class' do
      expect(members).to be_a Mailchimp::List::Members
    end

    it 'has a count' do
      expect(members.count).to eq member_count
    end

    it 'returns pages of members' do
      counts = []
      members.find_in_pages { |p| counts << p.count }
      expect(counts).to eq [page_size, page_size, page_size, 7]
    end

    it 'returns all members by paging' do
      count = 0
      members.find_each { |_| count += 1 }
      expect(count).to eq member_count
    end

    it 'has a Member for each item' do
      expect(members.sample).to be_a Mailchimp::List::Member
    end
  end

  context 'adding and deleting' do
    context '#create, #find_by, #delete, #first_or_create', vcr: { cassette_name: 'members' } do
      let(:list) { Mailchimp.connect.lists 'My first list' }
      let(:members) { list.members }

      it 'can add and delete a new instance' do
        name = 'Cat Sayers'
        data = { name: name, email_address: 'cat@sayers.cc', status: 'subscribed' }

        # #create
        expect { members.create data }.to change { list.members.count }.by(1)
        expect { members.create data }.to raise_error Mailchimp::Exception::Duplicate

        # #find_by
        member = list.members.find_by name: name
        expect(member).to be_a Mailchimp::List::Member
        expect(member.name).to eq name

        # #first_or_create finds the same instance
        member2 = list.members.first_or_create name: name
        expect(member.id).to eq(member2.id)

        # #delete
        expect { member.delete }.to change { list.members.count }.by(-1)

        # #first_or_create creates a new instance
        name = 'Dan Sayers'
        data = { name: name, email_address: 'dan@sayers.cc', status: 'subscribed' }
        member = members.first_or_create data
        expect(member.name).to eq name
        member.delete # Tidy up
      end
    end

    context '#create_or_update', vcr: { cassette_name: 'members_create_or_update' } do
      let(:list) { Mailchimp.connect.lists 'My first list' }
      let(:members) { list.members }

      it 'creates when no match is found, udates otherwise' do
        name = 'Cat Sayers'
        data = { name: name, email_address: 'cat@sayers.cc', status: 'subscribed' }

        # Create
        expect { members.create_or_update data }.to change { list.members.count }.by(1)

        # Update
        data = { first_name: 'Catherine', email_address: 'cat@sayers.cc', status: 'subscribed' }
        expect { members.create_or_update data }.not_to change { list.members.count }
        expect(members.create_or_update(data)).to have_attributes name: 'Catherine Sayers'

        # Unless we supply an id or equivalent, we won't end up updating anything
        data = { name: 'Catherine Sayers' }
        expect { members.create_or_update data }.not_to change { list.members.count }
        expect(members.create_or_update(data)).to have_attributes name: 'Catherine Sayers'
      end
    end
  end
end
