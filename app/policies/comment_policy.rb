class CommentPolicy < ApplicationPolicy
  #We want to list our topics publicly, allowing them to be viewed by anyone:
  # new visitors and logged in users.
end