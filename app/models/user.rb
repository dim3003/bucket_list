class User < ApplicationRecord

  has_many :comments
  has_many :ideas

  has_and_belongs_to_many :goals, class_name: 'Idea'

  has_secure_password

  validates :email, uniqueness: true

  before_validation :downcase_email

  after_initialize :default_role!

  validates :role, inclusion: { in: %w(registered admin) } 

  private

  def downcase_email
    self.email = email.downcase if email
  end

  def default_role!
    self.role ||= 'registered'
  end

end
