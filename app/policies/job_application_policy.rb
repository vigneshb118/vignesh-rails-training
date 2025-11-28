class JobApplicationPolicy < ApplicationPolicy
  def update?
    user&.employer? && record.job.company == user.company
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end


