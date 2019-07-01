class ArtworksController < ApplicationController
  def index
    @artworks = Artwork.all
    render json: @artworks
  end

  def create
    artwork = Artwork.new(art_work_params)

    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def show
    @artworks = Artwork.find(params[:id])
    render json: @artworks
  end

  def update
    @artwork = Artwork.find(params[:id])          # find artwork in database
    if @artwork.update                            # check if we can update artwork in database
      redirect '/artworks'
    else
      render json: @artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])           # automatically returns 404? to client if artwork to destroy not found in db
    @artwork.destroy
  end

  private
  def art_work_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end