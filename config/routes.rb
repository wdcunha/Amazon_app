Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get('/', { to: 'home#home', as: :home })
  get('/about', { to: 'about#about' })
  # get "/hello/:name" => "welcome#hello"
  # get "/hello/:name" => "welcome#hello",
  get('/contactus', { to: 'contactus#new' })
  post('/contactus_submit', { to: 'contactus#thankyou' })

end
