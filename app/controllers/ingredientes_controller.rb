class IngredientesController < ActionController::Base
  before_action :set_ingredient, only: [:show]

  def new
  end

  def create
  end

  def show
  end

  private
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end


end