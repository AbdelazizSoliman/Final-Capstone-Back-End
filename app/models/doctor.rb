class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  belongs_to :specialization
end
