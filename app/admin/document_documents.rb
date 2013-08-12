# -*- encoding : utf-8 -*-
ActiveAdmin.register Document::Document do
  form do |f|
     f.inputs "Document detail" do
       f.input :author
       f.input :description
       f.input :title
       f.input :realized_at
       f.input :number_of_pages
       f.input :study_level
       f.input :document_type
       f.input :user
       f.input :domains, collection: Domain.select_tree
     end
     f.actions
  end
end
