require 'rails_helper'

describe RecipesController do
  describe '#index' do
    before(:each) do
      stub_const('RecipesController::PER_PAGE', 3)
    end

    it 'returns recipes' do
      expected_titles = [
        'Crispy Chicken and Rice	with Peas & Arugula Salad',
        'Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing',
        'Tofu Saag Paneer with Buttery Toasted Pita'
      ]
      VCR.use_cassette(:recipes) do
        get :index

        recipes = assigns[:recipes]
        expect(recipes.size).to eq(described_class::PER_PAGE)
        titles = recipes.map(&:title)
        expect(titles).to eq(expected_titles)
      end
    end

    it 'returns decorated recipes' do
      VCR.use_cassette(:recipes) do
        get :index

        recipes = assigns[:recipes]
        expect(recipes).to be_decorated_with(RecipesDecorator)
      end
    end

    it 'returns specific page of recipes' do
      VCR.use_cassette(:recipes_page_2) do
        get :index, params: { page: 2 }

        recipes = assigns[:recipes]
        expect(recipes.size).to eq(1)
      end
    end

    context 'with error' do
      before(:each) do
        @content_type_id = Recipe.content_type_id
      end
      after(:each) do
        Recipe.content_type_id = @content_type_id
      end

      it 'returns error if has problem with content' do
        VCR.use_cassette(:recipes_with_error) do
          Recipe.content_type_id = 'wrong_recipe'
          get :index

          expect(response.status).to eq(503)
        end
      end
    end
  end

  describe '#show' do
    it 'returns recipe' do
      VCR.use_cassette(:recipe) do
        get :show, params: { id: '437eO3ORCME46i02SeCW46' }

        recipe = assigns[:recipe]
        expect(recipe.id).to eq('437eO3ORCME46i02SeCW46')
      end
    end

    it 'returns decorated recipe' do
      VCR.use_cassette(:recipe) do
        get :show, params: { id: '437eO3ORCME46i02SeCW46' }

        recipe = assigns[:recipe]
        expect(recipe).to be_decorated_with(RecipeDecorator)
      end
    end

    context 'with error' do
      before(:each) do
        @content_type_id = Recipe.content_type_id
      end
      after(:each) do
        Recipe.content_type_id = @content_type_id
      end

      it 'returns error if has problem with content' do
        VCR.use_cassette(:recipe_with_error) do
          Recipe.content_type_id = 'wrong_recipe'

          get :show, params: { id: '437eO3ORCME46i02SeCW46' }

          expect(response.status).to eq(503)
        end
      end
    end
  end
end
