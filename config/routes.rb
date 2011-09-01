Farfalla::Application.routes.draw do 

  match "translations/file/:file" , :to => "translations#file" , :as => "file" ,  :constraints => { :file => /.*/ } 
  resources :translations ,  :constraints => { :id => /.*/ } 
  
  get '/:page.html',
        :to => 'page#index',
        :defaults => { :page => "index" }

  root :to =>  "page#index" , :defaults => { :page => "index" }

end
