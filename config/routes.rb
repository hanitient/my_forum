Rails.application.routes.draw do
    resources :teas
  root 'static_pages#home'

  get 'password_resets/new'
  get 'password_resets/edit'

  get 'signup' => 'users#new'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,only: [:new, :create, :edit, :update]

  resources :diys
  resources :orders
 

  get'login'=> 'sessions#new'
  post'login'=> 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'addteas' => 'teas#new'
  post'addteas'=> 'teas#create'

  get'allteas' => 'teas#index'
  get'alljuices' => 'teas#index2'
  get'allhealths' => 'teas#index3'

  post'neworder'=> 'teas#new_order'

  get'introdiy' => 'diys#intro'
  get'adddiy' => 'diys#new'
  post'adddiy' => 'diys#create'
  get'alldiys' => 'diys#index'


  get 'addorder'=>'orders#new'
  post'addorder'=>'order#create'
  get 'allorder'=>'orders#indexall'


  #get 'static_pages/contact'
  #get 'static_pages/login'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
