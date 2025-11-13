# frozen_string_literal: true

class JobPolicy < ApplicationPolicy
  def new?
    user&.employer?
  end

  def create?
    user&.employer?
  end

  def edit?
    employer_owns_record?
  end

  def update?
    employer_owns_record?
  end

  def archive?
    employer_owns_record?
  end

  def apply?
    user&.seeker? && record.open?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def employer_owns_record?
    user&.employer? && record.company == user&.company
  end
end
