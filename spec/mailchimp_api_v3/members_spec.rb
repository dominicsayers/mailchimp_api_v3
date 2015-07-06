# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe Mailchimp::List::Members, vcr: { cassette_name: 'members', allow_playback_repeats: true } do
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
