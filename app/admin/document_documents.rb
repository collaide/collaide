ActiveAdmin.register Document::Document, as: 'Document' do
  menu parent: 'Document'
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  permit_params do
  # permitted = [:permitted, :attributes]
  # permitted << :other if resource.something?
  # permitted
    [:title,
     :description,
     :author,
     :number_of_pages,
     :asset,
     :file_cache,
     :realized_at,
     :language,
     :study_level,
     :document_type_id,
     :asset_cache,
     :user_id,
     :is_accepted,
     :status,
     :hits,
     :is_deleted,
     domain_ids: [],
    ]
  end

  index do
    selectable_column
    id_column
    column :title
    column :author
    column :user
    column :status
    column :created_at
    actions
  end

  filter :title
  filter :created_at
  filter :author
  filter :status
  filter :user
  
end
