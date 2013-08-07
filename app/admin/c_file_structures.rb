ActiveAdmin.register CFile::Structure do
  sortable tree: true,
           max_levels: 0, # infinite indent levels
           protect_root: false, # allow root items to be dragged
           sorting_attribute: :position,
           parent_method: :parent,
           children_method: :children,
           roots_method: :roots
  index :as => :sortable do
    label :name # item content
    default_actions
  end

  action_item { link_to "Stats", root_path }

  collection_action :stats do
    # stats stuff
  end

  form do |f|
    #TODO: Explorateur de fichier. On va rigoler...
    f.inputs "Domain Details" do
      #f.input :name
      #f.input :description

        f.inputs do
          f.input :name
          f.input :size
          f.input :files, as: :check_boxes
        end
    end
    f.actions
  end
end
