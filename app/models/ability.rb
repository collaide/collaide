# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    #utilisateur non connecté, à voir si ça va comme ça
    if user.nil?
       no_connected
    else
      # utilisateur normal, encore réfléchir comment exactement gérer, sinon un rôle 'normal' dans User ?
      if user.role.nil?
        normal_user user
      end
      if user.super_admin?
        super_admin
      end

      if user.admin?
        normal_user user
        admin
      end

      if user.validator?
        normal_user user
        validator
      end
    end
    #etc

    #can :manage, ActiveAdmin::Page, :name => "Domain"


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end

  private
    def no_connected
      can :manage, GuestBook
      can :read, Domain
      can :index, Document::Document
      can :read, Advertisement::Advertisement
    end

    def normal_user(user)
      can :manage, User, id: user.id #peut gérer uniquement son profil
      can :manage, GuestBook
      can :read, Domain
      can :read, Document::Document
      can :download, Document::Document
      can :manage, Document::Document, user_id: user.id
      can :manage, Advertisement::Advertisement, user_id: user.id
    end

    def super_admin
      can :manage, :all
    end

    def validator

    end

    def admin

    end
end
