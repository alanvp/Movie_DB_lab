class MoviesController < ApplicationController

  @@movie_db = [
          {"Title"=>"The Matrix", "Year"=>"1999", "imdbID"=>"tt0133093", "Type"=>"movie"},
          {"Title"=>"The Matrix Reloaded", "Year"=>"2003", "imdbID"=>"tt0234215", "Type"=>"movie"},
          {"Title"=>"The Matrix Revolutions", "Year"=>"2003", "imdbID"=>"tt0242653", "Type"=>"movie"}]

  # route: GET    /movies(.:format)
  def index
    @movies = @@movie_db

    respond_to do |format|
      format.html
      format.json { render :json => @@movie_db }
      format.xml { render :xml => @@movie_db.to_xml }
    end
  end
  # route: # GET    /movies/:id(.:format)
  def show
    @movie = @@movie_db.find do |m|
      m["imdbID"] == params[:id]
    end
    if @movie.nil?
      flash.now[:message] = "Movie not found"
      @movie = {}
    end
  end

  # route: GET    /movies/new(.:format)
  def new
  end

  # route: GET    /movies/:id/edit(.:format)
  def edit
    @movie = @@movie_db.find do |m|
      m["imdbID"] == params[:id]
    end

    if @movie.nil?
      flash.now[:message] = "Movie not found" if @movie.nil?
      @movie = {}
    end
  end

  #route: # POST   /movies(.:format)
  def create
    # create new movie object from params
    movie = params.require(:movie).permit(:Title, :Year)
    movie["imdbID"] = rand(10000..100000000).to_s
    # add object to movie db
    @@movie_db << movie
    # show movie page
    # render :index
    redirect_to action: :index
  end

  # route: PATCH  /movies/:id(.:format)
  def update
    movie = params.require(:movie).permit(:title, :year)
    @movie = @@movie_db.find do |m|
      m["imdbID"] == params[:id]
    end
    @movie["title"] = movie["title"]
    @movie["year"] = movie["year"]
 #   render :show
    redirect_to action: :index
  end

  # route: DELETE /movies/:id(.:format)
  def destroy
    @movie = @@movie_db.find do |m|
      m["imdbID"] == params[:id]
    end
    @@movie_db.delete(@movie)
    redirect_to action: :index
  end

# route: GET /movies/search
  def search
  end

# route: POST /movies/search
  def retrieve
    term = params.require(:movie).permit(:search_term)["search_term"]
    response = Typhoeus.get("www.omdbapi.com", :params => {:s => term})
    result = JSON.parse(response.body)["Search"]

    result.each do |el|

      @@movie_db << el
    end

    redirect_to action: :index
  end


  # private
  # def get_movie(movie_id)
  #   @movie = @@movie_db.find do |m|
  #     m["imdbID"] == movie_id
  #   end

  #   if @movie.nil?
  #     flash.now[:message] = "Movie not found" if @movie.nil?
  #     @movie = {}
  #   end    
  # end

end

