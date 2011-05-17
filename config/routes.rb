Farfalla::Application.routes.draw do |map|

  get '/:page.html',
        :to => 'page#index',
        :defaults => { :page => "index" }

  root :to =>  "page#index"
  
end
