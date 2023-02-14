# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :validate_admin

    def index
      @users = User.where.not(role: 1)
    end

    def show
      @user = User.find(params[:id])
      @movies = @user.viewing_parties.map do |vp|
        MovieFacade.movie_details(vp.movie_id)
      end
    end

    private

    def validate_admin
      return unless !current_user || current_user.default?

      flash[:error] = 'You are not authorized to access that page'
      redirect_to root_path
    end
  end
end
