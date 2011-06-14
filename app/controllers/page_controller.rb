class PageController < ApplicationController
  
  def index
    @page =  params[:page] || "index"
    response.headers['Content-type'] = 'text/html; charset=utf-8'
    render :template =>  @page
  end
  

end
