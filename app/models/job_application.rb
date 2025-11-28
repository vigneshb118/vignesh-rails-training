class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one_attached :resume, dependent: :destroy

  validates_presence_of :resume

  enum :status, {
    applied: 0,
    shortlisted: 1,
    interview: 2,
    rejected: 3,
    hired: 4
  }

  validates_uniqueness_of :user_id, scope: :job_id 
end
