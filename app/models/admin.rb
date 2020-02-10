class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable
  devise :database_authenticatable,
         :rememberable, :validatable
end
