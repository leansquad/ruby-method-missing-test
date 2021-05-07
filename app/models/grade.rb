class Grade < ApplicationRecord
  has_many :students

  validates :rank, presence: true, uniqueness: true
end
