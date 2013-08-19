# -*- encoding : utf-8 -*-
module ApplicationHelper
  def full_title(page_title)
    base_title = t :app_name
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def destroy_link(object, content = "Destroy")
    link_to(content, object, class: 'button alert', :method => :delete, :confirm => t('confirm')) if can?(:destroy, object)
  end

  def show_link(object, content = "Show")
    link_to(content, object, class: 'button') if can?(:read, object)
  end

  def edit_link(object, content = "Edit")
    link_to(content, [:edit, object], class: 'button warning') if can?(:update, object)
  end

  def create_link(object, content = "New", html_class='')
    if can?(:create, object)
      object_class = (object.kind_of?(Class) ? object : object.class)
      class_name = object_class.name.underscore.to_s.tr!('/', '_')
      link_to(content, [:new, class_name.to_sym], class: "button success #{html_class}")
    end
  end
end
