class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]

  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
    @fans = @movie.fans
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie successfully updated!'
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
      redirect_to @movie, notice: 'Movie successfully created!'
    else
      render :new # render the new template
    end
  end

  def destroy
    @movie = Movie.find(params[:id])

    if @movie.destroy
      redirect_to movies_path, alert: 'Movie successfully deleted!'
    else
      render :show # render the show template
    end
  end

  private

  def movie_params
    params
      .require(:movie)
      .permit(
        :title,
        :rating,
        :description,
        :released_on,
        :total_gross,
        :director,
        :duration,
        :image_file_name,
      )
  end
end
