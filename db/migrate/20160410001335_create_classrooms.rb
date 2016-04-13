class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name, null: false, default: ""
      t.belongs_to :teacher, null: false

      t.timestamps null: false
    end

    add_index :classrooms, :teacher_id
  end
end
