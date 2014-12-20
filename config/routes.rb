OfficeClerk::Engine.routes.append do
  resources :orders do
    member do
      get :rakennus
    end
  end
end

Farfalla::Application.routes.draw do 
  
  resources :translations ,  :constraints => { :id => /.*/ } do
    get "missing" , :on => :member
    get "file" , :on => :member
    post "search" , :on => :member
  end
  
  get '/:page.html',
        :to => 'page#index',
        :defaults => { :page => "index" }

  root :to =>  "page#index" , :defaults => { :page => "index" }

  mount OfficeClerk::Engine => "/"

end
