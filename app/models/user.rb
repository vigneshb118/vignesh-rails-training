class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :company_name, :company_description
  
  has_one :company, dependent: :destroy

  validates_presence_of :first_name, :last_name
  
  enum :user_type, { admin: 0, employer: 1, seeker: 2 }

  after_create :create_company

  private

  def create_company
    self.company = Company.create(name: company_name, description: company_description)
    self.save!
  end
end
