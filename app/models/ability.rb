# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user, request)
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
    rails_admin(request)

  end

  private
    def no_connected
      can :manage, GuestBook
      can [:read, :documents, :advertisements], User
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
      can :manage, User, id: user.id #peut gérer uniquement son profil
      can :downlaod, Document::Document
      can :manage, Document::Document, user_id: user.id #uniquement les documents créés par l'utilisateur
      can :manage, Advertisement::Advertisement, user_id: user.id #uniquement les annonces créées par l'utilisateur
      # TODO Gérer les messages avec le firewall
      can :manage, Message#, user_id: user.id #uniquement les messages de l'utilisateur
      can :create, Group::WorkGroup
      group_permisions user
    end

    def admin(user)
      normal user
    end

  def group_permisions(user)
    can :destroy, Group::Group do |group|
      member = Group::GroupMember.get_a_member user, group
      if member.nil? then
        false
      else
        group.can_delete_group.include?(member.role.to_sym)
      end
    end
  end

  def rails_admin(request)
    return unless request.nil? or request.fullpath.start_with? '/admin'
    cannot :new, Document::Download
    cannot :edit, Document::Download
    cannot :destroy, Document::Download
  end
end
