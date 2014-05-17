ActiveAdmin.register Group::WorkGroup, as: 'Travail' do
  menu parent: 'Groupe'
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end


  index do
    selectable_column
    id_column
    column :name
    column :description
    column :user
    column :created_at
    column :members do |ressource|
      ressource.members.size
    end
    column :topics do |ressource|
      ressource.topics.size
    end
    column :repo_items do |ressource|
      ressource.repo_items.size
    end
    actions
  end

  filter :name
  filter :description
  filter :created_at
  
end
