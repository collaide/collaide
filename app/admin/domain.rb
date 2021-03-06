ActiveAdmin.register Domain do
  sortable tree: true
  
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

  permit_params translations_attributes: [:locale, :id, :name, :description]


  index as: :sortable do
    label :name
    actions
  end

  index do
    selectable_column
    translation_status
    id_column
    column :name
    column :description
    actions
  end

  filter :name
  filter :description

  form do |f|
    f.translated_inputs "Translated fields", switch_locale: true do |t|
      t.input :name
      t.input :description
    end
    f.actions
  end
end
