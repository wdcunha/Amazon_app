Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :products
    end
  end

  # Admin related routes
  namespace :admin do
    # The `namespace` method takes a symbol as a first argument and a block
    # as an argument. It will prefix all routes defined inside the block
    # with the symbol given as a first argument.

    # It will also expect to find the related controllers in a subdirectory
    # named after the symbol (i.e. controllers/admin/...)

    # As well, it will expect said controllers to be part of a module
    # named after the symbol (i.e. Admin::DashboardController)
    resources :dashboard, only: [:index]
    get('/panel', { to: 'dashboard#panel' })

  end

  # session related routes
  # different of answer, we have just one session per user
  #
  resource :session, only: [:new, :create, :destroy]

  # User related routes
  resources :users, only: [:new, :create]

 # Product related routes
 resources :products  do
   # resources :reviews, shallow: true, only: [:create, :destroy] do
   resources :reviews, shallow: true, only: [:create, :edit, :update, :destroy] do
     resources :likes, only: [:create, :destroy], shallow: true
     resources :votes, only: [:create, :update, :destroy], shallow: true
   end
   resources :favourites, shallow: true, only: [:create, :destroy]
   resources :tags, only: [:show], shallow: true
 end
 resources :tags, only: [:index]

  get('/', { to: 'home#home', as: :home })
  get('/about', { to: 'about#about' })
  # get "/hello/:name" => "welcome#hello"
  # get "/hello/:name" => "welcome#hello",
  get('/contactus', { to: 'contactus#new' })
  post('/contactus_submit', { to: 'contactus#thankyou' })

end
