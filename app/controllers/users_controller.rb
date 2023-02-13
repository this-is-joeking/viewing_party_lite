# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.viewing_parties.map do |vp|
      MovieFacade.movie_details(vp.movie_id)
    end
  end

  def new
    @user = User.new
  end

  def create
    # require 'pry'; binding.pry
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
      flash[:alert] = 'User Created Successfully'
    else
      redirect_to register_path
      flash[:alert] = user.errors.full_messages.to_sentence
    end
  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      redirect_to user_path(user)
    else
      redirect_to login_path
      flash[:alert] = 'Could not find user with that password email combo, try again or register'
    end
    # require 'pry'; binding.pry
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
