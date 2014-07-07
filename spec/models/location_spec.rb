require 'rails_helper'

describe Location do
  it 'should build a hash' do
    expect(build(:location).build_hash.keys).to eq([:name, :coordinates, :fun_fact])
  end
end
