lass RecipeTagController < ActionController::Base

  before_action :set_measurement, only: [:destroy]

  def new
  end

  def create
  end

  def destroy
  end

  private
  def set_measurement
    @measurement = RecipeTag.find(params[:id])
  end

end
