# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :downcase_email, only: :create
  before_action :validate_user, only: :show

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
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
      flash[:alert] = 'User Created Successfully'
    else
      redirect_to register_path
      flash[:alert] = user.errors.full_messages.to_sentence
    end
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email].downcase)&.authenticate(params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user)
      flash[:message] = "Welcome #{user.name}"
    else
      redirect_to login_path
      flash[:alert] = 'Could not find user with that password email combo, try again or register'
    end
  end

  def logout_user
    session.delete(:user_id)
    redirect_to root_path
    flash[:alert] = 'Logout Successful'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def downcase_email
    params[:user][:email].downcase!
  end
end
