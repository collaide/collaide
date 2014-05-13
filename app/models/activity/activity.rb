# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: activity_activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer
#  trackable_type :string(255)
#  owner_id       :integer
#  owner_type     :string(255)
#  key            :string(255)
#  public         :boolean          default(FALSE)
#  parameters     :text
#  recipient_id   :integer
#  recipient_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Activity::Activity < ActiveRecord::Base

  # Define polymorphic association to the parent
  belongs_to :trackable, :polymorphic => true
  # Define ownership to a resource responsible for this activity
  belongs_to :owner, :polymorphic => true
  # Define ownership to a resource targeted by this activity
  belongs_to :recipient, :polymorphic => true
  # Serialize parameters Hash
  serialize :parameters, Hash

  has_many :activity_parameters, :class_name => 'Activity::Parameter'

  scope :public, -> { where(public: true) }


  # Virtual attribute returning text description of the activity
  # using the activity's key to translate using i18n.
  def text(params = {})
    # TODO: some helper for key transformation for two supported formats
    k = key.split('.')
    k.unshift('activity') if k.first != 'activity'
    k = k.join('.')

    I18n.t(k, parameters.merge(params) || {})
  end

  # Renders activity from views.
  #
  # @param [ActionView::Base] context
  # @return [nil] nil
  #
  # Renders activity to the given ActionView context with included
  # AV::Helpers::RenderingHelper (most commonly just ActionView::Base)
  #
  # The *preferred* *way* of rendering activities is
  # to provide a template specifying how the rendering should be happening.
  # However, one may choose using _I18n_ based approach when developing
  # an application that supports plenty of languages.
  #
  # If partial view exists that matches the *key* attribute
  # renders that partial with local variables set to contain both
  # Activity and activity_parameters (hash with indifferent access)
  #
  # Otherwise, it outputs the I18n translation to the context
  # @example Render a list of all activities from a view (erb)
  # <ul>
  # <% for activity in PublicActivity::Activity.all %>
  # <li><%= render_activity(activity) %></li>
  # <% end %>
  # </ul>
  #
  # = Layouts
  # You can supply a layout that will be used for activity partials
  # with :layout param.
  # Keep in mind that layouts for partials are also partials.
  # @example Supply a layout
  # # in views:
  # # All examples look for a layout in app/views/layouts/_activity.erb
  # render_activity @activity, :layout => "activity"
  # render_activity @activity, :layout => "layouts/activity"
  # render_activity @activity, :layout => :activity
  #
  # # app/views/layouts/_activity.erb
  # <p><%= a.created_at %></p>
  # <%= yield %>
  #
  # == Custom Layout Location
  # You can customize the layout directory by supplying :layout_root
  # or by using an absolute path.
  #
  # @example Declare custom layout location
  #
  # # Both examples look for a layout in "app/views/custom/_layout.erb"
  #
  # render_activity @activity, :layout_root => "custom"
  # render_activity @activity, :layout => "/custom/layout"
  #
  # = Creating a template
  # To use templates for formatting how the activity should render,
  # create a template based on activity key, for example:
  #
  # Given a key _activity.article.create_, create directory tree
  # _app/views/public_activity/article/_ and create the _create_ partial there
  #
  # Note that if a key consists of more than three parts splitted by commas, your
  # directory structure will have to be deeper, for example:
  # activity.article.comments.destroy => app/views/public_activity/articles/comments/_destroy.html.erb
  #
  # == Custom Directory
  # You can override the default `public_directory` template root with the :root parameter
  #
  # @example Custom template root
  # # look for templates inside of /app/views/custom instead of /app/views/public_directory
  # render_activity @activity, :root => "custom"
  #
  # == Variables in templates
  # From within a template there are two variables at your disposal:
  # * activity (aliased as *a* for a shortcut)
  # * parameters (aliased as *p*) [converted into a HashWithIndifferentAccess]
  #
  # @example Template for key: _activity.article.create_ (erb)
  # <p>
  # Article <strong><%= p[:name] %></strong>
  # was written by <em><%= p["author"] %></em>
  # <%= distance_of_time_in_words_to_now(a.created_at) %>
  # </p>
  def render(context, params = {})
    params[:i18n] and return context.render :text => self.text(params)

    context.render params.merge\
        partial: partial_path(*params.values_at(:partial, :partial_root)),
        layout: layout_path(*params.values_at(:layout, :layout_root)),
        locals: prepare_locals(params)
  end

  def partial_path(path = nil, root = nil)
    root ||= 'public_activity'
    path ||= self.key.to_s.gsub('.', '/')
    select_path path, root
  end

  def layout_path(path = nil, root = nil)
    path.nil? and return
    root ||= 'layouts'
    select_path path, root
  end

  def prepare_locals(params)
    locals = params.delete(:locals) || Hash.new

    #controller = PublicActivity.get_controller
    controller = Thread.current.object_id
    prepared_parameters = prepare_parameters(params)
    locals.merge\
        activity: self,
        controller: controller,
        current_user: controller.respond_to?(:current_user) ? controller.current_user : nil,
        parameters: prepared_parameters
  end

  def prepare_parameters(params)
    @prepared_params ||= self.parameters.with_indifferent_access.merge(params)
  end

  private
  def select_path path, root
    [root, path].map(&:to_s).join('/')
  end
end
