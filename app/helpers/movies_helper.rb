module MoviesHelper
  def total_gross(movie)
    return "Flop!" if movie.flop?
    number_to_currency(movie.total_gross, precision: 0)
  end

  def year_of(movie)
    movie.released_on.year
  end

  def format_average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, "No reviews")
    else
      pluralize(number_with_precision(movie.average_stars, precision: 1), "star")
    end
  end
end
