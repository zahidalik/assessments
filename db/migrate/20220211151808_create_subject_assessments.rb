class CreateSubjectAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table :subject_assessments do |t|
      t.string :subject
      t.integer :knowledge
      t.integer :presentation
      t.integer :clear_explanation
      t.integer :punctuality
      t.integer :hygiene_and_personality
      t.integer :akhlaq_and_behaviour
      t.integer :communication_with_students
      t.string :remarks
      t.references :teacher, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
