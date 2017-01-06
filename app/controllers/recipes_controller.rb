class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:show, :index, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  attr_accessor :measurs, :ingrs


  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @rating = Rating.new
    @comments=Comment.all
    @comment = Comment.new
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.build
  end


  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)
    @recipe.user = current_user
    @recipe.save
    @measurs = Array.new
    @ingrs = Array.new
    #ovo bi trebalo unutar sebe prikupiti sastojke i mjere
    parse_ingredients
    @recipe.measurements = @measurs
    @recipe.ingredients = @ingrs


    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    @measurs = Array.new
    @ingrs = Array.new
    #unisti prijasnje mjere(veze medu receptima i sastojcima)!
    @recipe.measurements.destroy
    #ovo bi trebalo unutar sebe prikupiti sastojke i mjere
    parse_ingredients
    @recipe.measurements = @measurs
    @recipe.ingredients = @ingrs

    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :description, :image)
    end

    def parse_ingredients
      line = params.require(:recipe).permit(:ingredients)[:ingredients]
      splitted = line.to_s.split("\r\n")
      splitted.each do |strLine|
        if strLine.starts_with?("{")
          next
        end
        array = strLine.split("\t")
        ingredient = Ingredient.create(name: array[1])
        @ingrs << ingredient
        @measurs << Measurement.create(ingredient: ingredient, recipe: @recipe, measure: array[0])
      end
    end

    def authorize_user!
      redirect_to recipes_path if current_user != @recipe.user
    end

end
