class TopicPolicy < ApplicationPolicy
  #We want to list our topics publicly, allowing them to be viewed by anyone:
  # new visitors and logged in users.
  def index?
    true
  end

  def create?
    user.present? && user.admin?
  end

  def update?
    create?
  end
end