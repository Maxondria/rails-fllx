module MoviesHelper
  def total_gross(movie)
    return 'Flop!' if movie.flop?
    number_to_currency(movie.total_gross, precision: 0)
  end

  def year_of(movie)
    movie.released_on.year
  end

  def format_average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, 'No reviews')
    else
      pluralize(
        number_with_precision(movie.average_stars, precision: 1),
        'star',
      )
    end
  end

  def nav_link_to(text, url)
    active_class = current_page?(url) ? 'active' : nil
    content_tag(:li, link_to(text, url, class: active_class))
  end

  def main_image(movie)
    if movie.main_image.attached?
      image_tag movie.main_image.variant(resize_to_limit: [150, nil])
    else
      image_tag 'placeholder.png'
    end
  end
end
