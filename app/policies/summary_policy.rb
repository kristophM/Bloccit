class SummaryPolicy < ApplicationPolicy
  #We want to list our topics publicly, allowing them to be viewed by anyone:
  # new visitors and logged in users.

  def create?
    user.present? 
  end

  def update?
    create?
  end
end