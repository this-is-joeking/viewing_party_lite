# frozen_string_literal: true

class DiscoverController < ApplicationController
  def index
    @user = current_user
  end
end
