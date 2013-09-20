# -*- encoding : utf-8 -*-
Collaide::Application.routes.draw do
  root :to => "static_pages#home", as: 'root'

  get "about", to: "static_pages#about", as: "about"
  get "contact", to: "static_pages#contact", as: "contact"
  get "help", to: "static_pages#help", as: "help"
  get 'change-lang', to: 'static_pages#change_lang', as: 'change_lang'
  match '/rate' => 'rater#create', :as => 'rate'

  resources 'messages'
  match 'reply', to: 'messages#reply', via: [:post]

  resources :advertisements, as: 'advertisement_advertisements', controller: 'advertisement/advertisements', :except => [:edit, :show]

  namespace :advertisement do
    #resources :delivery_mode
    #resources :payment_mode
    resources :books, :controller => "sale_books", as: 'sale_books', :except => [:index, :destroy] #on affiche tous les livres par advertisement#index
    get "test", to: "advertisements#test"
  end

  resources :'documents', as: 'document_documents', controller: 'document/documents' do
    get 'download', action: :download, as: 'download'
    get 'page/:page', :action => :index, :on => :collection, as: 'pager'
    get 'domain/:domain_id', action: :index, on: :collection, as: 'domain'
    get 'type/:type_id', action: :index, on: :collection, as: 'type'
    get ':type_id/in/:domain_id', action: :index, on: :collection, as: 'domain_type'
    get 'search/:query', action: :search, on: :collection, as: 'search'
    get 'autocomplete', action: :autocomplete, on: :collection, as: 'autocomplete'
    member do
      post :rate
    end
  end
  namespace :document do
    resources :domains, :only => [:show, :index]
    get 'json_tree', action: :json_tree, controller: 'document/domains'
    #resources :types
    #resources :study_levels
  end

  resources :structures, only: [:index] do
    resources :c_files
  end

  scope 'user/group/:id' do
    resources :structures
  end

  scope 'user/:id' do
    resources :structures
  end


  #namespace :user do
  #  resources :parameters
  #  resources :contacts
  #  resources :addresses
  #  resources :comments
  #  resources :statuses
  #  resources :schools
  #  resources :studies, :only => [:show, :update, :create, :new, :index, :edit]
  #
  #  resources :messages
  #  namespace :message do
  #    resources :inboxes
  #  end
  #
  #  resources :groups
  #  namespace :group do
  #    resources :users
  #    resources :demands
  #  end
  #
  #  resources :friends
  #  namespace :friend do
  #    resources :demands
  #  end
  #end


  resources :guest_books, :only => [:show, :index, :create, :new] do
    get 'page/:page', :action => :index, :on => :collection
  end
  resources :users, :only => [:show] do
    get 'no_credit', action: :no_credit, as: 'no_credit', on: :collection
  end

  devise_for :user
  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', {:prefix_on_default_locale => true})
end

Collaide::Application.routes.draw do

  match '/rate' => 'rater#create', :as => 'rate'

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  post 'pusher/auth'
  #match "*path", :to => "application#routing_error"
end
