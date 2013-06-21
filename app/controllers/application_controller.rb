class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :navigation
  include NavigationHelper

  def render_404
    redirect_to '/'
  end
end
