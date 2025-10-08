# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  def employer_actions?
    user&.employer?
  end

  def employer_owns_record?
    user&.employer? && record.user == user
  end

  alias_method :new?,    :employer_actions?
  alias_method :create?, :employer_actions?
  alias_method :show?,   :employer_owns_record?
  alias_method :edit?,   :employer_owns_record?
  alias_method :update?, :employer_owns_record?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
