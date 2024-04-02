class VotePolicy < ApplicationPolicy

  def index?
    member? or admin?
  end

  def show?
    member? or admin?
  end

  def create?
    member? or admin?
  end

  def destroy?
    member? or admin?
  end

  def update?
    member? or admin?
  end

  def edit?
    member? or admin?
  end

  def new?
    member? or admin?
  end
end
