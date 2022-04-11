class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie, only: %i[create destroy]

  def create
    @movie.fans << current_user unless @movie.fans.include?(current_user)

    redirect_to @movie, notice: "You favorited #{@movie.title}."
  end

  def destroy
    @movie.fans.delete(current_user) if @movie.fans.include?(current_user)

    redirect_to @movie, alert: "You unfavorited #{@movie.title}."
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
