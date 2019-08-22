require 'rails_helper'

describe RecipesDecorator do
  let(:recipes) { OpenStruct.new(total: 10, limit: 3) }
  let(:decorated_recipes) { described_class.decorate(recipes) }

  describe '#page' do
    it 'returns page from params' do
      decorated_recipes.h.params[:page] = 2
      expect(decorated_recipes.page).to eq(2)
    end

    it 'returns 1 if has not page in params' do
      expect(decorated_recipes.page).to eq(1)
    end
  end

  describe '#first_page' do
    it 'returns true if has not page param' do
      expect(decorated_recipes.first_page?).to be_truthy
    end

    it 'returns true if first page in params' do
      decorated_recipes.h.params[:page] = 1

      expect(decorated_recipes.first_page?).to be_truthy
    end

    it 'returns false if not first page' do
      decorated_recipes.h.params[:page] = 2

      expect(decorated_recipes.first_page?).to be_falsey
    end
  end

  describe '#last_page?' do
    it 'returns true if last page' do
      decorated_recipes.h.params[:page] = 4

      expect(decorated_recipes.last_page?).to be_truthy
    end

    it 'returns false if not last page' do
      decorated_recipes.h.params[:page] = 3

      expect(decorated_recipes.last_page?).to be_falsey
    end
  end
end
