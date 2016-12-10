class PagesController < ApplicationController
  def home
    redirect_to recipes_path if user_signed_in?
  end


end