class SubjectAssessment < ApplicationRecord
  belongs_to :teacher
  belongs_to :classroom

  validates_presence_of :subject
end
