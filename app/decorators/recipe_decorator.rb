class RecipeDecorator < ApplicationDecorator
  def tags_list
    tags.map { |tag| "##{tag.name}" }.join(', ')
  end
end
