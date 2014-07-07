require 'rails_helper'

describe Movie do
  it 'should build a json' do
    movie = build(:movie)
    allow(movie).to receive(:locations).and_return([build(:location)])
    expect(JSON.parse(movie.build_json).keys).to include('center', 'locations')
  end
end
