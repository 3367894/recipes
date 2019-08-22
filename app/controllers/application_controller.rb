class ApplicationController < ActionController::Base
  def process_action(*args)
    super
  rescue Contentful::BadRequest => exception
    render 'error/contentful_error', status: 503
  end
end
