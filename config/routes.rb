Wir2::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations", 
                                      :omniauth_callbacks => "users/omniauth_callbacks"},
                     :path => '', :path_names => {:sign_in => "login", :sign_out => "logout",
                                                  :sign_up => "register"}

  devise_scope :user do
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
    get "register", :to => "users/registrations#new"
    get "delete", :to => "users/registrations#destroy"
    get "settings", :to => "users/registrations#edit"
    get "settings/password", :to=> "users/registrations#password"
    get "settings/privacy", :to=> "users/registrations#privacy"
    get "search", :to=> "users#search"
    match '/search', to: 'users#search'
    get "profile", :to =>  "users#show"
  end 

  resources :users do
    member do
      get :follow
      get :unfollow
      get :unpend
      get :make_public
      get :make_private
    end
  end

  resources :notifications
  
  resources :pages
  resources :stories do
    member do
      get :vote_up
      get :vote_down
      get :unvote
      get :comment
    end
  end

  resources :comments
  resources :votes
  resources :relationships, only:[:create, :destroy]
  
  root :to => "pages#home"

  match '/about', to: 'pages#about'
  # get "/:id", :to => "users#show", :as => :user

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
