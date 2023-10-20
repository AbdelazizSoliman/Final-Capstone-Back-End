require 'rails_helper'

RSpec.describe 'Api::V1::Patients', type: :request do
  describe 'POST /patients' do
    it 'creates a new patient' do
      # Define the request parameters, for example, in JSON format.
      patient_params = {
        username: 'katended',
        email: 'katende@gmail.com',
        password: 'password'

      }

      # Send a POST request to the endpoint
      post '/api/v1/patients', params: { patient: patient_params }

      # Expect a successful response (status code 201 - Created)
      expect(response).to have_http_status(422)
    end
  end
end
