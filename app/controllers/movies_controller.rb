class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    movie_params = params
      .require(:movie)
      .permit(:title, :rating, :description, :released_on, :total_gross)

    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit # render the edit template
    end
  end
end
