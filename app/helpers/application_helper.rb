# -*- encoding : utf-8 -*-
module ApplicationHelper

  def full_title(page_title, sep = ' - ')
    options = {}
    options[:prepend] = t :app_name
    unless page_title.blank?
      options[:append] = page_title
    end
    find_t_for_meta('title_page', options).reverse.join(sep).html_safe
  end

  def key_words(words)
    if words.blank?
      find_t_for_meta('key_words', prepend: t('default_key_words')).join(', ').html_safe
    else
      "#{t('default_key_words')}, #{words}".html_safe
    end
  end

  def description(description)
    if description.blank?
      raw find_t_for_meta('description_meta', prepend: t('default_description_meta')).join(' ').html_safe
    else
      "#{t('default_description_meta')} #{description}".html_safe
    end
  end

  def destroy_link(object, content = "Destroy", html_class='')
    #link_to(content, object, class: "button alert #{html_class}", :method => :delete, :confirm => t('confirm')) if can?(:destroy, object)
    link_to(content, object, class: "#{html_class}", :method => :delete, :confirm => t('confirm')) if can?(:destroy, object)
  end

  def show_link(object, content = "Show", html_class='')
    link_to(content, object, class: "button #{html_class}") if can?(:read, object)
  end

  def edit_link(object, content = "Edit", html_class='')
    #link_to(content, [:edit, object], class: "button warning #{html_class}") if can?(:update, object)
    link_to(content, [:edit, object], class: "#{html_class}") if can?(:update, object)
  end

  def create_link(object, content = "New", html_class='')
    if can?(:create, object)
      object_class = (object.kind_of?(Class) ? object : object.class)
      class_name = object_class.name.underscore.to_s.tr!('/', '_')
      #link_to(content, [:new, class_name.to_sym], class: "button success #{html_class}")
      link_to(content, [:new, class_name.to_sym], class: "button #{html_class}")
    end
  end

  def like_button(url, data_layout = 'box_count')
    raw '<div class="fb-like" data-href="'+url+'" data-width="450" data-layout="'+data_layout+'" data-show-faces="false" data-send="false"></div>'
  end

  def display_date_or_year(date)
    (date == date.beginning_of_year) ?
        t('sale_books.show.published_date_year', published_date: date.strftime('%Y')) :
        t('sale_books.show.published_date', published_date: l(date, format: :long))
  end

  def blog_path
    'http://blog-oj-laneuveville.herokuapp.com'
  end

  def view_path
    controller.class.to_s.deconstantize.downcase+'/'+controller_name+'/'+action_name
  end

  def hidden_field_for_polymorphic(model, object, params = {})
    klass = params[:klass] || object.class.base_class.to_s
    hidden_field_tag("#{model}[klass]", klass) + hidden_field_tag("#{model}[id]", object.id) + hidden_field_tag("#{model}[path]", request.fullpath) + hidden_field_tag("#{model}[render_view]", view_path)
  end

  def image_and_name_for(writer, img = 'avatar')
    img_tag =  image_tag(writer.send(img).mini.url, alt: t("users.#{img}.alt", user: h(writer)), title: t("users.#{img}.title", user: h(writer)), width: 30, height: 30) if !img.blank? and writer.respond_to?(img)
    raw((link_to(img_tag+ h(writer), writer)).html_safe)
  end

  # View helper for rendering an activity, calls {Activity::Activity#render} internally.
  def render_activity activities, options = {}
    if activities.is_a? Activity::Activity
      activities.render self, options
    elsif activities.respond_to?(:map)
      return nil if activities.empty?
      # depend on ORMs to fetch as needed
      # maybe we can support Postgres streaming with this?
      activities.map {|activity| activity.render self, options.dup }.join.html_safe
    end
  end
  alias_method :render_activities, :render_activity

  # Helper for setting content_for in activity partial, needed to
  # flush remains in between partial renders.
  def single_content_for(name, content = nil, &block)
    @view_flow.set(name, ActiveSupport::SafeBuffer.new)
    content_for(name, content, &block)
  end

  private
    def find_t_for_meta(meta, options={})
      action_name = params[:action]
      action_name = 'new' if action_name == 'create'
      action_name = 'edit' if action_name == 'edit'
      controller_name = params[:controller].split('/')[1]
      module_name = params[:controller].split('/')[0]
      array_meta = []
      array_meta << options[:prepend] unless options[:prepend].nil?
      #if controller_name.blank?
      #  array_meta << t("")
      #end
      array_meta << t("#{module_name}.#{meta}", default: '')
      array_meta << t("#{module_name}.#{controller_name}.#{meta}", default: '')
      array_meta << t("#{module_name}.#{controller_name}.#{action_name}.#{meta}", default: '')
      array_meta << options[:append] unless options[:append].nil?
      remove_blank array_meta
    end

    def remove_blank(array)
      array.reject { |an_elem| an_elem.blank?}
    end
end
