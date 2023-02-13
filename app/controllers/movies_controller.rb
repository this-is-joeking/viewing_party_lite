# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    @movies = if params[:q] == 'top rated'
                MovieFacade.top_rated_movies
              else
                MovieFacade.discover_movies(params[:q])
              end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieFacade.movie_details(params[:id])
    @actors = MovieFacade.actors(params[:id])
    @reviews = MovieFacade.review_details(params[:id])
  end
end
