Farfalla::Application.routes.draw do |map|

  resources :translations
  
  get '/:page.html',
        :to => 'page#index',
        :defaults => { :page => "farfalla" }

  root :to =>  "page#index" , :defaults => { :page => "farfalla" }

end
