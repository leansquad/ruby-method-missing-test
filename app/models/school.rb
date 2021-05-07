class School < ApplicationRecord
  has_many :students
  belongs_to :county

  has_and_belongs_to_many :levels

  validates :name, presence: true, uniqueness: true
end
