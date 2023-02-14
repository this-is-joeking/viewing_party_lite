# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :current_user

  def index
    @movies = if params[:q] == 'top rated'
                MovieFacade.top_rated_movies
              else
                MovieFacade.discover_movies(params[:q])
              end
  end

  def show
    @movie = MovieFacade.movie_details(params[:id])
    @actors = MovieFacade.actors(params[:id])
    @reviews = MovieFacade.review_details(params[:id])
  end
end
