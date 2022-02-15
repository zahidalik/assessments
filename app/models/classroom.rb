class Classroom < ApplicationRecord
  belongs_to :teacher
  has_many :subject_assessments

  validates_presence_of :name, :section
end
