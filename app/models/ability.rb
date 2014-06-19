# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user, request=nil)
    #utilisateur non connecté, à voir si ça va comme ça
    if user.nil?
       no_connected
    else
      # utilisateur normal, encore réfléchir comment exactement gérer, sinon un rôle 'normal' dans User ?
      if user.role.nil?
        normal user
      end
      if user.super_admin?
        can :manage, :all
      end
      if user.admin?
        admin user
      end

      if user.doc_validator?
        normal user
        can :manage, Document::Document
        can :read, ActiveAdmin::Page, :name => "Dashboard"
      end
      if user.add_validator?
        normal user
        can :manage, Advertisement::Advertisement
        #La même chose que pour les documents —> créé la page adverstissement dans activeadmin
      end
    end

    #!!! Enlève des action pour certains modèles. Laisser à la fin!!!
    #rails_admin(request)

  end

  private
    def no_connected
      can :manage, GuestBook
      can [:read, :documents, :advertisements, :search, :avatar], User
      #can :read, Domain
      can :read, Document::Document
      can :search, Document::Document
      can :autocomplete, Document::Document
      can :read, Advertisement::Advertisement
      can :index, Group::Group
      can :new, Group::Group
    end

    def normal(user)
      no_connected
      can :manage do |requested_user|
        requested_user.id == user.id
      end
      can :downlaod, Document::Document
      can :manage, Document::Document, user_id: user.id #uniquement les documents créés par l'utilisateur
      can :manage, Advertisement::Advertisement, user_id: user.id #uniquement les annonces créées par l'utilisateur
      can :manage, Message
      can :manage, AppNotification, owner_id: user.id, owner_type: 'User' #uniquement les notifications de l'utilisateur

      can :create, Group::WorkGroup
      group_permissions user
    end

    def admin(user)
      normal user
    end

  def group_permissions(user)
    can :destroy, Group::Group do |group|
      group.can? :delete, :group, user
    end
    can :show, Group::WorkGroup do |wg|
      wg.can? :index, :activity, user
    end
    can :update, Group::WorkGroup do |wg|
      member = Group::GroupMember.get_a_member(user, wg)
      !member.nil? and member.admin?
    end
    can :members, Group::Group do |wg|
      wg.can? :index, :members, user
    end
    can :destroy, Group::EmailInvitation do |e_invitation|
      e_invitation.group_group.can? :manage, :invitations, user
    end
    can :create, Group::Invitation do |invitation|
      invitation.group.can? :create, :invitation, user
    end
    can :destroy, Group::Invitation do |invitation|
      invitation.group.can? :manage, :invitations, user
    end
    can :update, Group::Invitation do |invitation|
      invitation.receiver.id == user.id
    end

  end

  def polymorphic_topic(topic, user, action, subject)
    if topic.owner.is_a? Group::WorkGroup
      topic.owner.can? action, subject, user
    end
  end

  def rails_admin(request)
    return unless request.nil? or request.fullpath.start_with? '/admin'
    cannot :new, Document::Download
    cannot :edit, Document::Download
    cannot :destroy, Document::Download
  end
end
