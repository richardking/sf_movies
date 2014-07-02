class Api::MoviesController < ApplicationController

  def index
    @movies = Movie.all.map(&:title)
    render :json => @movies
  end

  def show
    @movie = Movie.find_by_title(params[:title])
    json = if @movie
             @movie.build_location_json
           else
             { :message => "cannot find movie by that title" }
           end
    render :json => json
  end
end
