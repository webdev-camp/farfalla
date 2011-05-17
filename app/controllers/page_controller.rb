class PageController < ApplicationController
  before_filter :locale
  
  def index
    @page =  params[:page] || "index"
    response.headers['Content-type'] = 'text/html; charset=utf-8'
    render :template =>  @page
  end
  
  protected
  
  def locale
    I18n.locale = :fi
  end

end
