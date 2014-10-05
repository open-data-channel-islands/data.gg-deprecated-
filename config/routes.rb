DataGg::Application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'home#index'

  devise_for :users

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

#  get 'buses/' => 'buses#index'

#  namespace :buses do
 #   resources :timetables, param: :start_date do
#      post 'publish' => 'timetables#publish'

 #     resources :stops
#      resources :stop_time_exceptions

#      resources :routes do
        # Make believe. Always work from the origin point.
#        resources :stop_times, param: :id do
#          get 'edit_individual' => 'stop_times#edit_individual', as: :edit_individual
          
#          post 'atomic_stop_time' => 'stop_times#add_exception', as: :add_exception
 #         delete 'remove_exception' => 'stop_times#remove_exception', as: :remove_exception
#        end

 #       resources :route_stops do
  #        collection do
   #         post 'create_stop_links'
    #      end
     #     
      #    post 'move_up'
       #   post 'move_down'
#        end
 #     end
  #  end
  #end
  
  
  get 'charts' => 'charts#index', as: 'charts_index'
  
  namespace :charts do
    get 'buses' => 'buses#index', as: 'buses_index'
    get 'housing' => 'housing#index', as: 'housing_index'
    get 'police' => 'police#index', as: 'police_index'
    get 'population' => 'population#index', as: 'population_index'
    get 'education' => 'education#index', as: 'education_index'
    get 'earnings' => 'earnings#index', as: 'earnings_index'
  end

  get 'developers' => 'developers#index', as: 'developers_index'
  
  namespace :developers do
    get 'buses' => 'buses#index', as: 'buses_index'
    get 'housing' => 'housing#index', as: 'housing_index'
    get 'police' => 'police#index', as: 'police_index'
    get 'population' => 'population#index', as: 'population_index'
    get 'education' => 'education#index', as: 'education_index'
    get 'earnings' => 'earnings#index', as: 'earnings_index'
    get 'flights' => 'flights#index', as: 'flights_index'
    get 'sailings' => 'sailings#index', as: 'sailings_index'
  end


  # API calls

  namespace :api do
    namespace "v10", path: "1.0", module: "v1_0" do

      #Buses
      namespace :buses do
        get 'timetables/list' => 'timetables#list'
        get 'timetables/current_version' => 'timetables#current_version'
      end
      
      #Police
      get 'police/crimes' => 'police#crimes'
      get 'police/traffic' => 'police#traffic'
      get 'police/traffic_collisions' => 'police#traffic_collisions'
      get 'police/traffic_injuries' => 'police#traffic_injuries'
      get 'police/traffic_classifications' => 'police#traffic_classifications'
      
      #Housing
      get 'housing/prices' => 'housing#prices'

    end
  end
  
  
  
  

  get 'api/v1/flights/', to: 'api/v1/flights#index'
  get 'api/v1/flights/arrivals', to: 'api/v1/flights#arrivals'
  get 'api/v1/flights/departures', to: 'api/v1/flights#departures'

  get 'api/v1/education/', to: 'api/v1/education#index'
  get 'api/v1/education/post16results', to: 'api/v1/education#post16results'
  get 'api/v1/education/gcse_overall', to: 'api/v1/education#gcse_overall'
  get 'api/v1/education/gcse_school', to: 'api/v1/education#gcse_school'

  get 'api/v1/population/', to: 'api/v1/population#index'
  get 'api/v1/population/population', to: 'api/v1/population#population'

  get 'api/v1/police/', to: 'api/v1/police#index'
  get 'api/v1/police/crimes', to: 'api/v1/police#crimes'
  get 'api/v1/police/traffic', to: 'api/v1/police#traffic'
  get 'api/v1/police/traffic_classifications', to: 'api/v1/police#traffic_classifications'
  get 'api/v1/police/traffic_collisions', to: 'api/v1/police#traffic_collisions'
  get 'api/v1/police/traffic_injuries', to: 'api/v1/police#traffic_injuries'

  get 'api/v1/earnings/', to: 'api/v1/earnings#index'
  get 'api/v1/earnings/earnings_age_group', to: 'api/v1/earnings#earnings_age_group'
  get 'api/v1/earnings/earnings_sector', to: 'api/v1/earnings#earnings_sector'
  get 'api/v1/earnings/earnings_sex', to: 'api/v1/earnings#earnings_sex'

  get 'api/v1/sailings/', to: 'api/v1/sailings#index'
  get 'api/v1/sailings/herm_trident', to: 'api/v1/sailings#herm_trident'
  get 'api/v1/sailings/harbour', to: 'api/v1/sailings#harbour'

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
