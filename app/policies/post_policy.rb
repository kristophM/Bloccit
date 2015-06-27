class PostPolicy < ApplicationPolicy
  #We want to list our posts publicly, allowing them to be viewed by anyone:
  # new visitors and logged in users.
  def index?
    true
  end
end