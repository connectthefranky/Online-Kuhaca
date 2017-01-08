class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:show, :index, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  attr_accessor :measurs, :ingrs


  # GET /recipes
  # GET /recipes.json
  def index
    query = params[:search]
    @search = Recipe.search do
      fulltext query
    end
    @recipes = @search.results
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
    @tgs = Array.new
    #ovo bi trebalo unutar sebe prikupiti sastojke i mjere
    parse_ingredients
    parse_tags
    @recipe.measurements = @measurs
    @recipe.ingredients = @ingrs
    @recipe.tags = @tgs

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
    @tgs = Array.new
    #unisti prijasnje mjere(veze medu receptima i sastojcima)!
    @recipe.measurements.destroy
    @recipe.tags.destroy
    @recipe.ingredients.destroy
    #ovo bi trebalo unutar sebe prikupiti sastojke i mjere
    parse_tags
    parse_ingredients

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

        if strLine.blank?
          next
        end

        array = strLine.split("\t")
        ingredient = Ingredient.find_or_create_by(name: array[1])
        @ingrs << ingredient
        @measurs << Measurement.find_or_create_by(ingredient_id: ingredient.id, recipe_id: @recipe.id, measure: array[0])
      end

      parse_tags
      @recipe.ingredients = @ingrs
      @recipe.measurements = @measurs
      @recipe.tags = @tgs
    end

    def parse_tags
      line = params.require(:recipe).permit(:tags)[:tags]

      splitted = line.to_s.split("\r\n")
      splitted.each do |strLine|
        if strLine.starts_with?("{")
          next
        end

        if strLine.blank?
          next
        end

        tag = Tag.find_or_create_by(title: strLine)
        @tgs << tag
      end
    end

    def authorize_user!
      redirect_to recipes_path if current_user != @recipe.user
    end

end
