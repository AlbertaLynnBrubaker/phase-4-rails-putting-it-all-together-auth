class RecipesController < ApplicationController

  def index
    recipes = Recipe.all
    
      if session[:user_id]
        render json: recipes, status: :ok
      else
        render json: {errors: ["Not Authorized"] }, status: :unauthorized
      end
  end

  def create
    user = User.find_by(id: session[:user_id])
    if user
      recipe = user.recipes.create!(recipe_params)
      render json: recipe, status: :created
    else
      render json: {errors: ["Not Authorized"] }, status: :unauthorized
    end
  end

  private

  def recipe_params
    params.permit(:id, :title, :instructions, :minutes_to_complete)
  end

end
