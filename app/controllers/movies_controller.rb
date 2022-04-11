class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @movies = Movie.send(movies_filter)

    # technically same as:

    # case params[:filter]
    # when 'upcoming'
    #   @movies = Movie.upcoming
    # when 'recent'
    #   @movies = Movie.recent
    # when 'hits'
    #   @movies = Movie.hits
    # when 'flops'
    #   @movies = Movie.flops
    # else
    #   @movies = Movie.released
    # end
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres.order(:name)
    @favorite =
      current_user.favorites.find_by(movie_id: @movie.id) if current_user
  end

  def edit; end

  def update
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
        genre_ids: [],
      )
  end

  def movies_filter
    if %w[flops upcoming hits recent].include? params[:filter]
      params[:filter]
    else
      :released
    end
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end
end
