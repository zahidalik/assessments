class User < ApplicationRecord
  validates_presence_of :name, :username

  has_secure_password

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :user_roles
  has_many :roles, through: :user_roles

  def is_super_admin?
    roles.any? {|role| role.kind == "super admin"}
  end

  def is_admin?
    roles.any? {|role| role.kind == "admin"}
  end

  def is_guest?
    roles.any? {|role| role.kind == "guest"}
  end
end
