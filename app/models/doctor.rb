class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
end
