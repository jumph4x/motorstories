class ProfilesController < ApplicationController

  def show
    @profile = Profile.find_by_username params[:id]
  end

  def index
  end
end
