DataGg::Application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'home#index'

  devise_for :users

  get "flights/index"
  get "flight/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



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

  get 'buses/' => 'buses#index'
  
  namespace :buses do
    resources :stop_time_exceptions

    resources :timetables, param: :start_date do
      
      post 'publish' => 'timetables#publish'

      resources :stops

      resources :routes do
        # Make believe. Always work from the origin point.
        resources :stop_times do
          get 'atomic_stop_time/:id' => 'stop_times#atomic_stop_time', as: :atomic_stop_time
          post 'atomic_stop_time/:id' => 'stop_times#add_exception', as: :add_exception
        end

        resources :route_stops do
          collection do
            post 'create_stop_links'
          end
        end
      end
    end
  end

  # TODO: These are all wrong; they should not be resources
  namespace :api do
    namespace "v10", path: "1.0", module: "v1_0" do
      
    #scope "1.0", module: "1_0" do
      # Buses API calls
      namespace :buses do
        get 'timetables/list' => 'timetables#list'
        get 'timetables/current_version' => 'timetables#current_version'
      end
      
    end
    



    namespace :v1 do

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
          get 'harbour'
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
