class MoviesController < ApplicationController
  before_action :find_movie, only: [:update, :destroy]

  def index
    render json:  Movie.all
  end

  def show
    render json: Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render :nothing => true, :status => 201
    else
      render :nothing => true, :status => 400
    end
  end

  def update
    if @movie.update(movie_params)
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 400
    end
  end

  def destroy
    if @movie.destroy
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 400
    end
  end

  private

  def find_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title)
  end
end
