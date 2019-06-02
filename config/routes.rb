Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'movies' => 'movie#index'

  get 'seasons' => 'season#index'

  get 'library' => 'library#index_all'
end
