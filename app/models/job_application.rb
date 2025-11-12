class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job

  enum :status, {
    applied: 0,
    shortlisted: 1,
    interview: 2,
    rejected: 3,
    hired: 4
  }
end
