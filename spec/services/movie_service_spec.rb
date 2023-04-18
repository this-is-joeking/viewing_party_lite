# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieService, :vcr do
  it 'can return a movie object' do
    response = MovieService.movie_details(238)

    expect(response).to be_a(Hash)
    expect(response[:id]).to eq(238)
    expect(response[:title]).to be_a(String)
    expect(response[:vote_average]).to be_a(Float)
    expect(response[:genres][0][:name]).to be_a(String)
    expect(response[:runtime]).to be_a(Integer)
  end

  it 'can return movie cast' do
    response = MovieService.actors(238)
    actor = response[:cast][0]

    expect(response[:cast]).to be_a(Array)
    expect(actor[:name]).to be_a(String)
    expect(actor[:character]).to be_a(String)
  end

  it 'can return movie reviews' do
    response = MovieService.review_details(238)
    review = response[:results][0]

    expect(response).to be_a(Hash)
    expect(review[:author]).to be_a(String)
    expect(review[:author_details][:rating]).to be_a(Float)
    expect(review[:content]).to be_a(String)
  end

  it 'can return top rated movies' do
    response = MovieService.top_rated_movies
    top_movie = response[:results][0]

    expect(response[:results].count).to eq(20)
    expect(top_movie[:title]).to be_a(String)
    expect(top_movie[:vote_average]).to be_a(Float)
  end

  it 'can return movies based on search' do
    response = MovieService.discover_movies('The Matrix')
    search_movie = response[:results][0]

    expect(response[:results].count).to be <= 20
    expect(search_movie[:title]).to be_a(String)
    expect(search_movie[:vote_average]).to be_a(Float)
  end

  it 'can return trending movies by week' do
    response = MovieService.trending('week')
    trending_movie = response[:results][0]

    expect(response[:results].count).to eq(20)
    expect(trending_movie[:title]).to be_a(String)
    expect(trending_movie[:vote_average]).to be_a(Float)
  end
end
