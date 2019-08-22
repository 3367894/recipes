class RecipesController < ApplicationController
  PER_PAGE = 20

  def index
    @recipes = RecipesDecorator.decorate(
      Recipe.paginate(page, PER_PAGE, ['fields.title', 'sys.id']).load
    )
  end

  def show
    @recipe = RecipeDecorator.decorate(Recipe.find(params[:id]))
  end

  private

  def page
    (params[:page] || 1).to_i
  end
end
