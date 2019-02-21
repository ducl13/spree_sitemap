Spree::Core::Engine.routes.draw do
  resources :sitemap, :controller => 'sitemap/migrate', :only => [:index]
end
