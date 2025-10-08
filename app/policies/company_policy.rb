# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  def employer_actions?
    user&.employer?
  end

  alias_method :new?,    :employer_actions?
  alias_method :create?, :employer_actions?
  alias_method :show?,   :employer_actions?
  alias_method :edit?,   :employer_actions?
  alias_method :update?, :employer_actions?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
