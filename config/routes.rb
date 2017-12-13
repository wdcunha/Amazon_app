Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # session related routes
  # different of answer, we have just one session per user
  #
  resource :session, only: [:new, :create, :destroy]

  # User related routes
  resources :users, only: [:new, :create]

 # Product related routes
 resources :products  do
   resources :reviews, only: [:create, :destroy]
 end

  get('/', { to: 'home#home', as: :home })
  get('/about', { to: 'about#about' })
  # get "/hello/:name" => "welcome#hello"
  # get "/hello/:name" => "welcome#hello",
  get('/contactus', { to: 'contactus#new' })
  post('/contactus_submit', { to: 'contactus#thankyou' })

end
