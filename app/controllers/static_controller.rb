class StaticController < ApplicationController
  http_basic_authenticate_with name: "love", password: "stories" if Rails.env.production?

  def index #tour
  end

  def credits
  end

end
