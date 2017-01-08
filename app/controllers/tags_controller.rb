class TagsController < ActionController::Base
  before_action :set_tag, only: [:show]

  def new
  end

  def create
  end

  def show
  end

  private
  def set_ingredient
    @tag = Tag.find(params[:id])
  end


end
