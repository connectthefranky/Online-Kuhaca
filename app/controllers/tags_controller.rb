class TagsController < ActionController::Base
  before_action :set_tag, only: [:show]

  def new
  end

  def create
  end

  def show
    @recipe_tags = RecipeTag.select { |rt| rt.tag_id == @tag.id}
    @tmp = []

    @recipe_tags.each do |r|
      @tmp << Recipe.select { |rc| rc.id == r.recipe_id }
    end

    @recipes = @tmp
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end


end
