DataGg::Application.routes.draw do

  devise_for :users
  
  get "flights/index"
  get "flight/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  
  get 'about' => 'home#about', as: :about
  get 'help' => 'home#help', as: :help

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

  #get 'buses/' => 'buses#index'


  #namespace :buses do
  #  get 'api/latest.:format' => 'api#latest'

    # Because these are distinct
  #  resources :stops

    # Can download XML/Object/JSON/HTML
  #  get 'timetables/:date/download/:type' => 'timetables#download', as: :timetables_download

  #  resources :timetables, param: :start_date do
  #    resources :routes do
  #      resources :route_stops
  #    end
  #  end
  #end

  # TODO: These are all wrong; they should not be resources
  namespace :api do
    namespace :v1 do

      
      get 'buses/' => 'buses#index'

      namespace :buses do
        
        resources :timetables, param: :start_date do
          collection do
            get 'current_version'
            get 'list'
          end
          
          get ':version/data' => 'timetables#data'
          
          resources :stops
          
          resources :routes do
            resources :route_stops do
              collection do
                post 'create_stop_links'
              end
            end
          end
        end
        
      end
      
      resources :flights do
        collection do
          get 'arrivals'
          get 'departures'
        end
      end

      resources :police do
        collection do
          get 'crimes'
          get 'traffic'
          get 'traffic_classifications'
          get 'traffic_collisions'
          get 'traffic_injuries'
        end
      end

      resources :population do
        collection do
          get 'population'
        end
      end

      resources :earnings do
        collection do
          get 'earnings_age_group'
          get 'earnings_sector'
          get 'earnings_sex'
        end
      end

      resources :sailings do
        collection do
          get 'herm_trident'
        end
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
