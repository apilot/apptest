class Course < ApplicationRecord
  include Authority::Abilities

  belongs_to :teacher

  has_many :discipline_courses, dependent: :destroy
  has_many :disciplines, through: :discipline_courses
  has_many :sections, dependent: :destroy
  #has_many :lessons, dependent: :restrict_with_error

  validates :name, presence: true
  validates :description, presence: true
  validates :disciplines, presence: false

  #mount_uploader :mail_image, MainCourseImageUploader

  #accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

  end
