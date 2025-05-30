module MoviesHelper
    def total_gross(movie)
        if movie.flop?
            "Flop!"
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
    end

    def year_of(movie)
        # movie.released_on.strftime("%Y")
        movie.released_on.year
    end

    def average_stars(movie)
      if movie.average_stars.zero?
        content_tag(:strong, "No reviews")
      else
        # pluralize(number_with_precision(movie.average_stars, precision: 1) , "star")
        "*" * movie.average_stars.round
      end
    end

    def nav_link_to(text, url)
      if current_page?(url)
        link_to(text, url, class: "rounded-md bg-gray-900 px-3 py-2 text-sm font-medium text-white", aria: { current: "page" })
      else
        link_to(text, url, class: "rounded-md px-3 py-2 text-sm font-medium text-red-300 hover:bg-red-700 hover:text-white")
      end
    end

    def main_image(movie)
      image_tag movie.image_file_name
      # image_tag "#{movie.to_param}.png"
      # if movie.main_image.attached?
      #   # image_tag movie.main_image
      #   image_tag movie.main_image.variant(resize_to_limit: [150, nil])
      # else
      #   image_tag "placeholder.png"
      # end
    end
end
