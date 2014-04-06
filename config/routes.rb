# -*- encoding : utf-8 -*-
Collaide::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root to: 'static_pages#home', as: 'root'
  localized do
    root :to => "static_pages#home", as: 'root'

    get "about", to: "static_pages#about", as: "about"
    get "contact", to: "static_pages#contact", as: "contact"
    get "help", to: "static_pages#help", as: "help"
    get 'partners', to: 'static_pages#partners', as: 'partners'
    get 'rules', to: 'static_pages#rules', as: 'rules'
    get 'change-lang', to: 'static_pages#change_lang', as: 'change_lang'
    post 'contact', to: 'static_pages#send_email', as: 'send_email_contact'
    #get 'board', to: 'static_pages#board', as: 'board'
    #post '/rate' => 'rater#create', :as => 'rate'

    resources 'notifications', only: [:index] do
      get 'page/:page', action: :index, on: :collection
    end

    #resources :messages
    #resources :conversations

    resources 'messages' do
      #post 'reply', action: :reply
      collection do
        get 'page/:page', action: :index
        get 'sentbox', action: :sentbox
        get 'trash', action: :trash
        get 'all', action: :all
        get 'contact-for/book/:id_book', action: :new, as: :contact_book
        #get 'search', action: :search, as: 'search'
        #get 'autocomplete', action: :autocomplete, as: 'autocomplete'
      end
    end
    match 'reply', to: 'messages#reply', via: [:post]

    resources :advertisements, as: 'advertisement_advertisements', controller: 'advertisement/advertisements', :except => [:edit, :show] do
      collection do
        get 'page/:page', :action => :index, as: 'pager'
        get 'search', action: :search, as: 'search'
        get 'autocomplete', action: :autocomplete, as: 'autocomplete'
      end
    end

    namespace :advertisement do
      resources :books, :controller => 'sale_books', as: 'sale_books', :except => [:index, :destroy] #on affiche tous les livres par advertisement#index
    end

    concern :has_repository do
      resources :repo_items, only: [:index, :show, :destroy] do
        get 'download'
        patch 'copy', action: :copy
        patch 'move', action: :move
        patch 'rename', action: :rename
        collection do
          post 'folder', action: :create_folder, :as => 'create_folder'
          post 'file', action: :create_file, :as => 'create_file'
          post 'files', action: :create_files
        end
        resources :sharings, only: [:new, :create, :destroy] do

        end
      end
    end

    concern :topic do
      resources :topics, only: [:index, :show, :new]
    end

    concern :invitation do
      resources :invitations, only: [:create, :destroy, :update]
    end

    concern :member do
      resources :members, only: [:create]
    end

    concern :email_invitation do
      resources :email_invitations, only: [:destroy] do
        patch ':id/secret_token/:secret_token', action: :update, on: :collection, as: ''
        get ':id/secret_token/:secret_token', action: :update, on: :collection, as: ''
      end
    end

    resources :topics, only:[:create]
    resources :comments, only: [:create]

    resources :groups, as: 'group_groups', controller: 'group/groups' do
      collection do
        #get 'page/:page', :action => :index, as: 'pager'
        #get 'search', action: :search, as: 'search'
        #get 'autocomplete', action: :autocomplete, as: 'autocomplete'
      end
    end

    namespace :group do
      resources :work_groups, :controller => 'work_groups', as: 'work_groups', :only => [:new, :create, :edit, :update, :show] do
        concerns :has_repository
        concerns :topic
        concerns :invitation
        concerns :member
        concerns :email_invitation
        get 'members', action: :members, as: 'members'
      end
    end



    resources :'documents', as: 'document_documents', controller: 'document/documents' do
      get 'download', action: :download, as: 'download'
      get 'page/:page', :action => :index, :on => :collection, as: 'pager'
      get 'domain/:domain_id', action: :index, on: :collection, as: 'domain'
      get 'type/:type_id', action: :index, on: :collection, as: 'type'
      get ':type_id/in/:domain_id', action: :index, on: :collection, as: 'domain_type'
      get 'search', action: :search, on: :collection, as: 'search'
      get 'autocomplete', action: :autocomplete, on: :collection, as: 'autocomplete'
      get 'downloaded', action: :downloaded, on: :collection, as: 'downloaded'
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

    #resources :structures, only: [:index] do
    #  resources :c_files
    #end

    #scope 'user/group/:id' do
    #  resources :structures
    #end

    #scope 'user/:id' do
    #  resources :structures
    #end


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
    #  resources :advertisements
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

    #devise_for :user
    #A voir...
    #devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

    resources :users do
      get 'no_credit', action: :no_credit, as: 'no_credit', on: :collection
      get 'page', action: :page, as: 'page', on: :collection
      get 'documents', action: :documents, as: 'documents'
      get 'advertisements', action: :advertisements, as: 'advertisements'
      get 'invitations',  action: :invitations, as: 'invitations'
      get 'avatar'
    end

    #devise_scope :user do
    #  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
    #end
  end
  get 'users/search' => 'users#search', as: 'search_users'
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, :controllers => {omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations' }
end
