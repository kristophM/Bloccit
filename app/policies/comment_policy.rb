class CommentPolicy < ApplicationPolicy
  #We want to list our topics publicly, allowing them to be viewed by anyone:
  # new visitors and logged in users.
  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end
end