class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :description, presence: true

  acts_as_list
end
