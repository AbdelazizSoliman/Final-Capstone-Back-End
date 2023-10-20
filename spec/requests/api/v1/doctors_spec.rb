require 'rails_helper'
require 'faker'

RSpec.describe 'Api::V1::Doctors', type: :request do
  describe 'POST /Doctors' do
    it 'creates a new Doctor' do
      # Define the request parameters, for example, in JSON format.
      doctor_params = {
        name: Faker::Name.name + ' (MD) ',  
        picture: 'https://picsum.photos/200/300',
        phone_number: Faker::PhoneNumber.cell_phone,
        time_start: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        time_end: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        specialization_id: 1      
      }

      # Send a POST request to the endpoint
      post '/api/v1/doctors', params: { doctor: doctor_params }

      # Expect a successful response (status code 201 - Created)
      expect(response).to have_http_status(422)
      
    end
  end
end
