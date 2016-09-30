class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_page

  protected

  def set_page
    @page =  params[:page] || "index"
  end

end
