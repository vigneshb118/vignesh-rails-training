class Company < ApplicationRecord
  belongs_to :user
  has_many :jobs, dependent: :destroy

  validates_presence_of :name, :description
end
