require 'rails_helper'

describe RecipeDecorator do
  describe '#tags_list' do
    let(:recipe) do
      tags = (1..3).map { |index| OpenStruct.new(name: "Tag #{index.to_s}") }
      OpenStruct.new(tags: tags)
    end
    let(:decorated_recipe) { described_class.decorate(recipe) }

    it 'returns list of tags' do
      expect(decorated_recipe.tags_list).to eq("#Tag 1, #Tag 2, #Tag 3")
    end
  end
end
