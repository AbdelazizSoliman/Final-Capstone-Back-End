require 'rails_helper'

RSpec.describe 'Api::V1::Appointments', type: :request do
  describe 'GET /index' do
    it 'creates a new Appointment' do
      # Define the request parameters, for example, in JSON format.
      appointment_params = {
        date_of_appointment: Faker::Date.between(from: '2023-01-01', to: '2023-12-31'),
        time_of_appointment: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now).strftime('%H:%M:%S'),
        city: Faker::Address.city,
        doctor: Doctor.all.sample, # Randomly select a doctor
        patient: Patient.all.sample # Randomly select a patient
      }

      # Send a POST request to the endpoint
      post '/api/v1/appointments', params: { appointment: appointment_params }

      # Expect a successful response (status code 201 - Created)
      expect(response).to have_http_status(422)
    end
  end
end
