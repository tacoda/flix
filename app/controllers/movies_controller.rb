class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    before_action :set_movie, only: [:show, :edit, :update, :destroy]

    def index
      @movies = Movie.send(movies_filter)
    end

    def show
      @review = @movie.reviews.new
      @fans = @movie.fans
      @genres = @movie.genres
      if current_user
        @favorite = current_user.favorites.find_by(movie_id: @movie.id)
      end
    end

    def edit
    end

    def update
      if @movie.update(movie_params)
        # flash[:notice] = 'Movie successfully updated!'
        # redirect_to @movie
        redirect_to @movie, notice: 'Movie successfully updated!'
      else
        render :edit
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
        render :new
      end
    end

    def destroy
      @movie.destroy
      # redirect_to movies_url, alert: 'Movie successfully deleted!'
      redirect_to movies_url, danger: "I'm sorry, Dave, I'm afraid I can't do that."
    end

    private

    def set_movie
      @movie = Movie.find_by!(slug: params[:id])
    end

    def movie_params
      params.require(:movie)
            .permit(:title, :description, :rating, :released_on,
                    :total_gross, :director, :duration, :main_image,
                    genre_ids: [])
    end

    def movies_filter
      if params[:filter].in? %w(upcoming recent hits flops)
        params[:filter]
      else
        :released
      end
    end
end
