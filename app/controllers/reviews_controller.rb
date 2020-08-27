class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.create(create_update_review_params)
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Please enter title, rating, and content in order to submit a review."
      redirect_to "/shelters/#{@shelter.id}/reviews/new"
    end
  end

  def edit
    @shelter_id = params[:id]
    @review_id= params[:review_id]
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    shelter = Shelter.find(params[:id])
    if review.update(create_update_review_params)
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = "Title, rating, and content are required in order to edit review."
      redirect_to "/shelters/#{shelter.id}/reviews/#{review.id}/edit"
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end

  def create_update_review_params
    rp = review_params.to_hash
    rp["image"] = nil if rp["image"].empty?
    rp
    # review_params[:image] = nil if review_params[:image].empty?
  end

  # def review_params
  #    params_allowed = [:title, :rating, :content]
  #    params_allowed << :image if !["image"].empty?
  #    params.permit(params_allowed)
  # end
end