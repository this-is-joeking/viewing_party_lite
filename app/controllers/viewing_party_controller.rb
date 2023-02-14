# frozen_string_literal: true

class ViewingPartyController < ApplicationController
  before_action :find_user, only: %i[new create]
  def new
    if !current_user
      flash[:error] = 'You must be logged in / registered to create a movie party'
      redirect_to user_movie_path(@user, params[:movie_id])
    else
      @movie = MovieFacade.movie_details(params[:movie_id])
      @viewing_party = ViewingParty.new
      @users = @user.all_other_users
    end
  end

  def create
    @vp = ViewingParty.new(viewing_party_params)
    if @vp.save
      create_vp_users
      redirect_to user_path(@user)
    else
      redirect_to new_user_movie_viewing_party_path(@user, params[:movie_id])
      flash[:alert] = @vp.errors.full_messages.to_sentence
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def create_vp_users
    ViewingPartyUser.create(viewing_party: @vp, user: @user, hosting: true)
    viewing_party_users_params.each do |user_id|
      ViewingPartyUser.create(viewing_party_id: @vp.id, user_id: user_id, hosting: false) if User.exists?(user_id)
    end
  end

  def viewing_party_params
    params.require(:viewing_party).permit(:party_duration, :date, :start_time, :movie_id)
  end

  def viewing_party_users_params
    params[:viewing_party][:user_ids]
  end
end
