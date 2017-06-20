class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == wiki.user
  end

  def destroy?
    return true if user.present? && user == wiki.user
  end

  private

  def article
    record
  end
end
