class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :locale

  protected
  
  def locale
    I18n.locale = :fi
    @page =  params[:page] || "index"
  end

end
