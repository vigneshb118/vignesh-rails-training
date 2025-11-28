class Job < ApplicationRecord
  belongs_to :company
  has_many :job_applications, dependent: :destroy

  validates_presence_of :title, :description, :job_type, :salary
  validates_numericality_of :salary, greater_than: 0

  enum :job_type, { full_time: 0, part_time: 1, contract: 2, internship: 3 }
  enum :status, { open: 0, archived: 1 }
end
