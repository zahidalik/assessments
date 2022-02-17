class Role < ApplicationRecord
  validates_presence_of :kind

  has_many :user_roles
  has_many :users, through: :user_roles

  def to_s
    kind
  end
end
