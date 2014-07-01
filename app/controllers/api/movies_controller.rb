class Api::MoviesController < ApplicationController

  def index
    @movies = Movie.all.map(&:title)
    render :json => @movies
  end

  def show
    @movie = Movie.find(params[:id])
    @locations = @movie.locations.map{|l| [l.longitude, l.latitude]}
    render :json => @locations
  end
end
