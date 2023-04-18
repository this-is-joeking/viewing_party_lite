# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieFacade, :vcr do
  it 'returns a cast (array of actors)' do
    cast = MovieFacade.actors(238)

    cast.each do |actor|
      expect(actor).to be_a Actor
    end
  end

  it 'returns a movie' do
    movie = MovieFacade.movie_details(238)

    expect(movie).to be_a Movie
  end

  it 'returns an array of reviews' do
    reviews = MovieFacade.review_details(238)

    reviews.each do |review|
      expect(review).to be_a Review
    end
  end

  it 'returns an array of top rated movies' do
    movies = MovieFacade.top_rated_movies

    movies.each do |movie|
      expect(movie).to be_a Movie
    end
  end

  it 'returns an array of queried movies' do
    movies = MovieFacade.discover_movies('The Matrix')

    movies.each do |movie|
      expect(movie).to be_a Movie
    end
  end

  it 'returns an array of trending movies for the week' do
    movies = MovieFacade.trending_movies('week')
    
    movies.each do |movie|
      expect(movie).to be_a Movie
    end
  end

  it 'returns an array of trending movies for the day' do
    movies = MovieFacade.trending_movies('day')
    
    movies.each do |movie|
      expect(movie).to be_a Movie
    end
  end
end
