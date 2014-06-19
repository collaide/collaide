# -*- encoding : utf-8 -*-
module SanitizeHelper

  # https://github.com/rgrove/sanitize
  def s(text, config = nil)
    if config.nil?
      config = get_custom_relaxed_config
      config[:transformers] = [accept_specified_style,
                               #linkify_urls,
                               #remove_empty_elements,
      ]
      Sanitize.clean(text, config)
    else
      Sanitize.clean(text, config)
    end
  end

  def cite_a_part(text, quote = '"', truncate=30)
    #text = truncate(text, lenght: truncate, escape: false)
    #"#{quote}#{s(text, Sanitize::Config::RESTRICTED)}#{quote}".html_safe
    "#{quote}#{truncate(strip_tags(text), lenght: truncate, escape: false)}#{quote}".html_safe
  end

  private
    def get_custom_relaxed_config
      @config = Sanitize::Config::RELAXED.deep_dup
      @config[:add_attributes] = {
          'a' => {'rel' => 'nofollow'}
      }
      @config[:elements].push('span')
      @config
    end

    def get_custom_relaxed_inner_config
      @inner_config = get_custom_relaxed_config
      @inner_config[:attributes][:all].push('style')
      @inner_config
    end

    def accept_specified_style
      lambda do |env|
        node      = env[:node]
        inner_config = get_custom_relaxed_inner_config

        # Don't continue if this node is already whitelisted or is not an element.
        return if env[:is_whitelisted] || !node.element? || !node['style']

        accepted_styles = ['text-decoration: line-through;', 'text-decoration: underline;', 'text-align: left;',
                           'text-align: center;', 'text-align: right;', 'text-align: justify;', 'list-style-type: circle;',
                           'list-style-type: disc;, list-style-type: square;', 'list-style-type: lower-alpha;', 'list-style-type: lower-greek;',
                           'list-style-type: lower-roman;', 'list-style-type: upper-alpha;', 'list-style-type: upper-roman;', 'padding-left: 30px;',
                           'padding-left: 60px;', 'padding-left: 90px;', 'padding-left: 120px;']
        return unless accepted_styles.include? node['style']

        # We're now certain that this is a YouTube embed, but we still need to run
        # it through a special Sanitize step to ensure that no unwanted elements or
        # attributes that don't belong in a YouTube embed can sneak in.
        Sanitize.clean_node!(node, inner_config)

        # Now that we're sure that this is a valid YouTube embed and that there are
        # no unwanted elements or attributes hidden inside it, we can tell Sanitize
        # to whitelist the current node.
        {:node_whitelist => [node]}
      end
    end

  ## TODO : Changer aussi les adresses qui commencent par "www",
  ## TODO: faire la methode replace_text_with_node
  #def has_anchor_ancestor(node)
  #  until node.nil?
  #    return true if node.name == 'a'
  #    node = node.parent
  #  end
  #  return false
  #end
  #
  #def replace_text_with_link(node, original_text, link_text, url)
  #  # the text itself becomes a link
  #  link = Nokogiri::XML::Node.new('a', node.document)
  #  link['href'] = url
  #  link.add_child(Nokogiri::XML::Text.new(link_text, node.document))
  #  return replace_text_with_node(node, original_text, link)
  #end
  #
  #def linkify_urls
  #  lambda do |env|
  #    node = env[:node]
  #    return unless node.text?
  #    return if has_anchor_ancestor(node)
  #    url_reference = node.text.match(/(\s|^|\()(https?:\/\/[^\s)\]]*)/i)
  #    return if url_reference.nil?
  #    resulting_nodes = replace_text_with_link(node, url_reference[2], url_reference[2], url_reference[2])
  #    # sanitize the new nodes ourselves; they won't be picked up otherwise.
  #    resulting_nodes.delete(node)
  #    resulting_nodes.each do |new_node|
  #      Sanitize.clean_node!(new_node, env[:config])
  #    end
  #  end
  #end

  def remove_empty_elements
    lambda {|env|
      node = env[:node]
      return unless node.elem?

      unless node.children.any?{|c| !c.text? || c.content.strip.length > 0 }
        node.unlink
      end
    }
  end

end
