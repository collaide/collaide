# -*- encoding : utf-8 -*-
module ApplicationHelper
  def full_title(page_title)
    base_title = t :app_name
    if page_title.empty?
      base_title.html_safe
    else
      "#{page_title} - #{base_title}".html_safe
    end
  end

  def destroy_link(object, content = "Destroy", html_class='')
    link_to(content, object, class: "button alert #{html_class}", :method => :delete, :confirm => t('confirm')) if can?(:destroy, object)
  end

  def show_link(object, content = "Show", html_class='')
    link_to(content, object, class: "button #{html_class}") if can?(:read, object)
  end

  def edit_link(object, content = "Edit", html_class='')
    link_to(content, [:edit, object], class: "button warning #{html_class}") if can?(:update, object)
  end

  def create_link(object, content = "New", html_class='')
    if can?(:create, object)
      object_class = (object.kind_of?(Class) ? object : object.class)
      class_name = object_class.name.underscore.to_s.tr!('/', '_')
      link_to(content, [:new, class_name.to_sym], class: "button success #{html_class}")
    end
  end

  def like_button(url, data_layout = 'box_count')
    raw '<div class="fb-like" data-href="'+url+'" data-width="450" data-layout="'+data_layout+'" data-show-faces="false" data-send="false"></div>'
  end
end
