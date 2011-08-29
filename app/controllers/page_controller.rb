class PageController < ApplicationController
  
  def index
    @page =  params[:page] || "index"
    response.headers['Content-type'] = 'text/html; charset=utf-8'
    if template_exists? @page
      render :template =>  @page
    else
      render :template =>  "page/three"
    end
  end
  

end
