class SearchController < ApplicationController
  def index
  end

  def search
    query = params[:query]
    @students = StudentProfile.search(query)
    @colleges = College.search(query)
    render :index
  end
end
