class Api::MoviesController < ApplicationController

  def index
    @movies = Movie.all.map(&:title)
    render :json => @movies
  end

  def show
    @movie = Movie.find_by_title(params[:title])
    if @movie
      render :json => @movie.build_location_json
    else
      render :json => { :status => "404", :error => "cannot find movie by that title" }, :status => 404
    end
  end
end
