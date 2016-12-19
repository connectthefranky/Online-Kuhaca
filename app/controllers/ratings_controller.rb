class RatingsController < ApplicationController
  

  def create
    if (Rating.where(:user => current_user, :recipe_id => rating_params[:recipe_id]).length > 0)
      rating = Rating.where(:user => current_user, :recipe => rating_params[:recipe_id]).first
      rating.destroy
    end
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    @rating.save
    redirect_to recipe_path(@rating.recipe)
  end

  def update
    respond_to do |format|
      if @recipe.update(rating_params)
        format.html { redirect_to @recipe, notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


  private
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:rating, :user_id, :recipe_id)
    end

end
