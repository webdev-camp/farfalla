OfficeClerk::Engine.routes.append do
  resources :orders do
    member do
      get :rakennus
    end
  end
  resources :resellers do
    collection do
      get "search" => "resellers#index"
    end
  end
end

Rails.application.routes.draw do

  resources :translations ,  :constraints => { :id => /.*/ } do
    get "missing" , :on => :member
    get "file" , :on => :member
    post "search" , :on => :member
  end

  get '/:page.html',
        :to => 'page#index',
        :defaults => { :page => "index" }
  #
  # Roots added by webdev.camp (us)
  root :to =>  "shop#index"
  get "/category/:id", :to => 'shop#show', as: :category
  # The as: :show_product is where we define the path/url for use with link_to helper.
  get "/product/:id", :to => 'shop#show_product', as: :show_product

  
  mount OfficeClerk::Engine => "/"

  match '*path', via: :all, to: 'page#error_404' #if Rails.production?

end
