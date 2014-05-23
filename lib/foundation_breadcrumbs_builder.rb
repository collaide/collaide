# -*- encoding : utf-8 -*-
# This gist was inspired by bootstrap breadcrumbs builder

# https://gist.github.com/chourobin/4219700
# You can use it with the :builder option on render_breadcrumbs:
#     <%= render_breadcrumbs :builder => ::FoundationBreadcrumbsBuilder, :separator => "&raquo;" %>
#
# Note: You may need to adjust the autoload_paths in your config/application.rb file for rails to load this class:
#     config.autoload_paths += Dir["#{config.root}/lib/"]
#

class FoundationBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:ul, :class => 'breadcrumbs') do
      @elements.collect do |element|
        render_element(element)
      end.join.html_safe
    end
  end

  def render_element(element)
    current = @context.current_page?(compute_path(element))

    @context.content_tag(:li, :class => ('current' if current)) do
      @context.link_to(compute_name(element), compute_path(element), element.options)
    end
  end
end
