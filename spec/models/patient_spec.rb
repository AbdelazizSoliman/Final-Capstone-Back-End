require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe '#username'
  context 'when username is nil' do
    it 'returns true without a when all fields are' do
      patient = Patient.create(username: 'John Doe', email: 'john@example.com', password: 'password123',
                               password_confirmation: 'password')
      patient.username = nil
      expect(patient.valid?).to be(false)
    end
  end
end
