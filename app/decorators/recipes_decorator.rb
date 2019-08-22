class RecipesDecorator < ApplicationDecorator
  def first_page?
    page.blank? || page == 1
  end

  def last_page?
    page == (total / limit.to_f).ceil
  end

  def page
    @page ||= (h.params[:page] || 1).to_i
  end
end
