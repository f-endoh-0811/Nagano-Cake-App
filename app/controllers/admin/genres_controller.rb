class Admin::GenresController < ApplicationController
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to genres_path
  end
  
  def update
    @genre = Genre.update(genre_params)
    @genre.update
    redirect_to genres_path
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
