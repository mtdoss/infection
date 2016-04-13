class CreateJoinTableEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :student_id, null: false
      t.integer :classroom_id, null: false
      t.timestamps null: false
    end
  end
end
