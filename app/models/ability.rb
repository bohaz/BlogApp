class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest user

    if user.role == 'admin'
      can :manage, :all
    else
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
    end
  end
end
