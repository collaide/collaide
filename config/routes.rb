  Collaide::Application.routes.draw do

    resources :documents do
      get 'domain/:domain', action: :index, on: :collection, as: 'documents_by_domain'
      get 'page/:page', :action => :index, :on => :collection
    end
      namespace :document do
        resources :domains, :only => [:show, :index]
        resources :types
        resources :study_levels
      end

      resources :structures, only: [:index] do
        resources :c_files
      end

      scope 'member/group/:id' do
        resources :structures
      end

      scope 'user/:id' do
        resources :structures
      end


      namespace :member do
        resources :parameters
        resources :contacts
        resources :addresses
        resources :comments
        resources :statuses
        resources :schools
        resources :studies, :only => [:show, :update, :create, :new, :index, :edit]

        resources :messages
        namespace :message do
          resources :inboxes
        end

        resources :groups
        namespace :group do
          resources :members
          resources :demands
        end

        resources :friends
        namespace :friend do
          resources :demands
        end
      end


      resources :guest_books, :only => [:show, :index, :create, :new] do
        get 'page/:page', :action => :index, :on => :collection
      end
      resources :users,   :only => [:show]

      match "about", to: "static_pages#about", as: "about"
      match "contact", to: "static_pages#contact", as: "contact"
      match "help", to: "static_pages#help", as: "help"
      match 'change-lang', to: 'static_pages#change_lang', as: 'change_lang'

      root to: "static_pages#home"

      devise_for :user
      ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { :prefix_on_default_locale => true })
  end

  Collaide::Application.routes.draw do


    ActiveAdmin.routes(self)
    devise_for :admin_users, ActiveAdmin::Devise.config
    match "*path", :to => "application#routing_error"
  end