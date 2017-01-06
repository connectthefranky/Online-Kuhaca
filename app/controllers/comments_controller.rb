class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.user_email = current_user.email
    @comment.save
    redirect_to recipe_path(@comment.recipe)
  end

  def update
    respond_to do |format|
      if @recipe.update(comment_params)
        format.html { redirect_to @recipe, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  private
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :recipe_id)
    end

end
