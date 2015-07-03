# encoding: utf-8
require 'spec_helper'
require 'mailchimp_api_v3'

describe MailchimpAPIV3::List::Members, vcr: { cassette_name: 'members' } do
  let(:page_size) { 10 }
  let(:member_count) { 37 }
  let(:list) { MailchimpAPIV3.connect.lists.first }
  let(:members) { list.members 'page_size' => page_size }

  it 'is the expected class' do
    expect(members).to be_a MailchimpAPIV3::List::Members
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
    expect(members.sample).to be_a MailchimpAPIV3::List::Member
  end
end
