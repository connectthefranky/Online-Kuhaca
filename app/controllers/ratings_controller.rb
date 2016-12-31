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

    recipe = Recipe.where(:id => rating_params[:recipe_id]).first
    num = Rating.where(:recipe => rating_params[:recipe_id]).length
    sum = 0
    Rating.where(:recipe => rating_params[:recipe_id]).each do |r|
      sum = sum + r.rating.to_s.to_i
    end
    avg = (sum.to_f/num).round(2)
    recipe.update(average_rating: avg) 
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
