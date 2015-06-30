class PostPolicy < ApplicationPolicy
  #We want to list our posts publicly, allowing them to be viewed by anyone:
  # new visitors and logged in users.
  def index?
    true
  end

  class Scope < ApplicationPolicy::Scope

    def resolve
      if user.nil?
        scope.none
      elsif user.admin? || user.moderator?
        scope.all
      else #if users are just a member
        scope.where(user: user)
      end
    end
  end
end