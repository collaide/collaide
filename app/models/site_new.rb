# -*- encoding : utf-8 -*-
class SiteNew
  require 'net/http'
  attr_accessor :host

  def initialize(host='')
    host.blank? ? @host = 'blog-oj-laneuveville.herokuapp.com' : @host = host
    @methods = {}
    @methods[:get_recent_posts] = 'get_recent_posts'
  end

  def get_recent_posts(options = {})
    execute(@methods[:get_recent_posts], options)
  end

  private
    def execute(method, options={})
      more = ''
      more = options.map {|an_option, a_value| "#{an_option}=#{a_value}"}.join('&')
      more = '&' + more unless more.blank?
      JsonResponse.new Net::HTTP.get(host, "/?json=#{method}#{more}")
    end
end

class JsonResponse
  attr_accessor :json_text, :json_hash

  def initialize(json)
    @json_text = json
    @json_hash = JSON.parse(json_text)
  end

  def get(sym)
    if sym == :posts
      return get_posts json_hash[sym.to_s]
    end
    json_hash[sym.to_s]
  end

  def json=(json)
    @json_text = json
    @json_hash = JSON.parse(json_text)
  end

  def status
    get :status
  end

  private
    def get_posts(hash)
      hash.map do |a_post|
        p = Post.new
        p.title = a_post['title']
        p.url = a_post['url']
        p.id = a_post['id']
        p.slug = a_post['slug']
        p.status = a_post['status']
        p.content = a_post['content']
        p.date = a_post['date']
        p
      end
    end
end

class Post
  attr_accessor :title, :url, :id, :slug, :status, :title_plain, :content, :excerpt, :date, :date_modified
end
