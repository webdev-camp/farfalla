class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :locale

  protected
  
  def locale
    I18n.locale = :fi
  end

end
