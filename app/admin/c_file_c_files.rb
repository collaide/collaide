# -*- encoding : utf-8 -*-
ActiveAdmin.register CFile::CFile do
  form do |f|
    f.inputs "File Details" do
      f.input :file_file_name
      f.input :rights, :as => :check_boxes, :collection => CFile::CFile::RIGHTS.map { |role| [role, role] }
    end
    f.actions
  end
end
