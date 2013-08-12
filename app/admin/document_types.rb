# -*- encoding : utf-8 -*-
ActiveAdmin.register Document::Type do

  form do |f|
    f.inputs "Document Type Details" do
      #f.input :name
      #f.input :description

      f.globalize_inputs :translations do |lf|
        lf.inputs do
          lf.input :locale
          lf.input :name
          lf.input :description

          lf.input :locale, :as => :hidden
        end
      end
    end
    f.actions
  end
end
