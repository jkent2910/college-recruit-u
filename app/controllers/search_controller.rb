class SearchController < ApplicationController
  def index
  end

  def search
    query = params[:query]
    @students = StudentProfile.search(query).where(incognito: false)
    @colleges = College.search(query)
    render :index
  end
end
