class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.supervisor?
      can :manage, Course do |course|
        course.users.include? user
      end
      can :read, Course
    else
      can :show, Course do |course|
        course.users.include? user
      end
    end
  end
end
