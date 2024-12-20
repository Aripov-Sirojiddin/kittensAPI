require "flickr"

class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find_by(id: params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    kitten = Kitten.create(kitten_params)
    if kitten.save
       redirect_to kitten
    else
      render :new, :unprocessable_entry
    end
  end

  def edit
    @kitten = Kitten.find_by(id: params[:id])
  end

  def update
    kitten = Kitten.find_by(id: params[:id])
    if kitten.update(kitten_params)
      redirect_to kitten
    else
      render :edit, :unprocessable_entry
    end
  end

  def destroy
    kitten = Kitten.find_by(id: params[:id])
    if kitten.present?
      kitten.destroy
    end
    redirect_to root_path
  end

  def search_results
    # @api_key = Rails.application.credentials.flickr[:api_key]
    flickr = Flickr.new Rails.application.credentials.flickr[:api_key], Rails.application.credentials.flickr[:api_secret]
    @results = flickr.photos.search text: "Kitten " + params[:search_term].to_s
  end

  private
  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
