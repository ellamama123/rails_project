class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    
    if user.profile && user.profile.is_admin?
      can :manage, :all
    else
      can :read, :all
      cannot :access, :root
    end
  end
end
