class User < ActiveRecord::Base
  has_many :enrollments, foreign_key: :student_id
  has_many :teachers, through: :enrollments
  has_many :students, through: :classrooms
  has_many :classrooms, foreign_key: :teacher_id
  # has_many :enrolled_classes, ->{ order("classrooms.period ASC") }, through: :enrollments, source: :classroom, class_name: "Classroom"

end
