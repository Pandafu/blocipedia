class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    user.present?
  end

  def destroy?
    user.admin?
  end

  def create?
    if user.premium? && wiki.private?
      return true
    else
      return false
    end
  end
end
