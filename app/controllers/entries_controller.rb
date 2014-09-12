class EntriesController < ApplicationController
  rescue_from MongoMapper::DocumentNotFound, :with => :render_404
  helper :navigation

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

private
  def vehicle

  end
end

