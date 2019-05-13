class ArtistsController < ApplicationController
  def index
    if Preference.artist_sort_order == "ASC"
      @artists = Artist.order("name ASC")
    elsif Preference.artist_sort_order == "DESC"
      @artists = Artist.order("name DESC")
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    #binding.pry
    if p.allow_create_artists == false 
      redirect_to artists_path 
    else
      @artist = Artist.new
    end
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
