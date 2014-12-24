Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :students, :houses
  get '/school_sort' => "students#school_sort", :as => :sort_school
end
