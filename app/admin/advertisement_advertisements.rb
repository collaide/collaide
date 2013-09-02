# -*- encoding : utf-8 -*-
ActiveAdmin.register Advertisement::Advertisement do
  form do |f|
     f.inputs "Advertisement detail" do
       f.input :title
       f.input :description
       #f.input :price
       #f.input :currency
       #f.input :annotation
       #f.input :state
       #f.input :delivery_modes
       #f.input :payment_modes
       f.input :user
       #f.input :domains, collection: Domain.select_tree
       f.input :active
       f.input :language
     end
     f.actions
  end
end
