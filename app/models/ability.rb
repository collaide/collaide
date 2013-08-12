# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    #utilisateur non connecté, à voir si ça va comme ça

    if user.nil?
      can :manage, GuestBook
      can :read, Domain
      can :index, Document::Document
    else
      if user.no_roles? #utilisateur normal, encore réfléchir comment exactement gérer, sinon un rôle normal dans User
        can :manage, User, id: user.id #peut gérer uniquement son profil
        can :manage, GuestBook
        can :read, Domain
        can :read, Document::Document
        can :manage, Document::Document, user_id: user.id
      else
        if user.is? 'super-admin'
          can :manage, :all
        end

        if user.is? 'admin'
          #can :read, User par exemple
          #etc on continue de définir des permissions pour chaque rôles
        end
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
end
