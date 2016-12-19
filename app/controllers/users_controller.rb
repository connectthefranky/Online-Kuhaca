class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  private
  def after_confirmation_path_for(resource_name, resource)
    recipes_path
  end
end
