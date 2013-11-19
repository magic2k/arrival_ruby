ArrivalRuby::Application.routes.draw do

  # get "employees"          => "employees#index"
  # get 'employee'           => "employees#show"
  # delete "employee"        => "employees#destroy"
  # resource :employees, only: [:show, :destroy]
  resources :employees

  root 'employees#report'
  get  'report'           =>    'employees#report'
  post 'personal_report'  =>    'employees#personal_report'
  post 'overall_report'   =>    'employees#overall_report'
  post 'workdays_select'  =>    'employees#workdays_select'
  get  'today_report'     =>    'employees#today_report'
  post  'get_xlsx'         =>    'employees#get_xlsx'

  get 'admin'             =>    'admin#index'
  get 'admin/remote_db'
  get 'admin/populate_db' =>    'admin#populate_db'

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
