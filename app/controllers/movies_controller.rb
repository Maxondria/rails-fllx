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

    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit # render the edit template
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie
    else
      render :new # render the new template
    end
  end

  def destroy
    @movie = Movie.find(params[:id])

    if @movie.destroy
      redirect_to movies_path
    else
      render :show # render the show template
    end
  end

  private

  def movie_params
    params
      .require(:movie)
      .permit(:title, :rating, :description, :released_on, :total_gross)
  end
end
