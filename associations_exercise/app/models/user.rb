# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord

  has_many :enrollments,
  primary_key: :id,
  foreign_key: :student_id,
  class_name: :Enrollment

  has_many :enrolled_courses,
  through: :enrollments,
  source: :course

  has_many :enrolled_courses_prerequisites,
  through: :enrolled_courses,
  source: :prerequisite

  has_many :instructed_courses,
  primary_key: :id,
  foreign_key: :instructor_id,
  class_name: :Course
end
