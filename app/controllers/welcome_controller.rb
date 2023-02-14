# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @users = User.where.not(role: 1)
  end
end
