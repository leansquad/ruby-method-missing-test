class Student < ApplicationRecord
  belongs_to :school
  belongs_to :grade

  validates :first_name, :last_name, presence: true
end
