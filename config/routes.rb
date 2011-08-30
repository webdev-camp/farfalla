Farfalla::Application.routes.draw do 

  resources :translations ,  :constraints => { :id => /\w{2,}(\.\w{2,})?/ } do
    collection do
       get :files
     end
  end
  
  get '/:page.html',
        :to => 'page#index',
        :defaults => { :page => "index" }

  root :to =>  "page#index" , :defaults => { :page => "index" }

end
