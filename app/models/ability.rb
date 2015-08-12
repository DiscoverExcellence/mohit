class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  
    
    if user.role == "admin"
      can :manage, :all
    end

    if user.role == "tournament_manager"
      can :read, :all
      can :manage, Tournament, :user_id => user.id
      can :manage, Player
      can :manage, Match
    end

    if user.role == "player_manager"
      can :read, :all
      can :manage, Player, :user_id => user.id
    end

    if user.role == "user"
      can :read, :all
    end

=begin
    can :create, Tournament if user.role == "tournament_manager"
    can :manage, Tournament, :user_id => user.id
    can :read, :all if user.role == "player_manager"
    can :create, Player if user.role == "player_manager"
    #can :read, Game, :name=>"TENNIS" if user.role == "admin"
    #can :create, Tournament if user.role == "admin"
    #can :manage, Tournament if user.role == "admin"
    #can :read, :all if user.role.nil?
=end
    # Define abilities for the passed in user here. For example:
    #
    #user ||= User.new # guest user (not logged in)
    #  if user.admin?
    #    can :manage, :all
    #  else
    #    can :read, :all
    #  end
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
