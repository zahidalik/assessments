class CreateClassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :section
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
