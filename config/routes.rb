Farfalla::Application.routes.draw do 

  resources :translations do
    collection do
       get :files
     end
  end
  
  get '/:page.html',
        :to => 'page#index',
        :defaults => { :page => "index" }

  root :to =>  "page#index" , :defaults => { :page => "index" }

end
