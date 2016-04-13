class Enrollment < ActiveRecord::Base
  belongs_to :student, inverse_of: :enrollments, class_name: "User"
  belongs_to :classroom
  has_one :teacher, through: :classroom, class_name: "User"
end
