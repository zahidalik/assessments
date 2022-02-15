class Teacher < ApplicationRecord
  validates_presence_of :name

  has_many :classrooms
  has_many :subject_assessments

  extend FriendlyId
  friendly_id :name, use: :slugged
end
