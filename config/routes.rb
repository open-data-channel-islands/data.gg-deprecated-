DataGg::Application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
  
  
  # Note that the rails docs say this:
  #   "Resources should never be nested more than 1 level deep." (Section 2.7.1 'Limits to nesting' - http://guides.rubyonrails.org/routing.html)
  # In this case I think because of the complexity, it's justified, and easier to navigate to

  get 'buses/' => 'buses#index'
  

  namespace :buses do
    
    get 'new' => 'timetables#new'
    post 'create' => 'timetables#create'
    
    # Because these are distinct
    resources :stops
    
    # In yyyymmdd format
    scope ':date' do
      
      
      
      # Timetables
      
      get '' => 'timetables#show', as: :timetable
      delete '' => 'timetables#destroy', as: :delete_timetable
      
      # Routes
      get ':id' => 'timetables/routes#show', as: :route
      delete ':id' => 'timetables/routes#destroy', as: :delete_route
      get 'new' => 'timetables/routes#new', as: :new_route
      post 'create' => 'timetables/routes#create', as: :create_route
      get 'edit' => 'timetables/routes#edit', as: :edit_route
      put 'update' => 'timetables/routes#update', as: :update_route
      
      # Route stops
      scope ':route_name' do
        get '/' => 'route_stop#show'
      end
    end
    
   
  end

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
