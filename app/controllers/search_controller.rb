class SearchController < ApplicationController
  def index
  end

  def search
    p params
    redirect_to :search
  end
end
