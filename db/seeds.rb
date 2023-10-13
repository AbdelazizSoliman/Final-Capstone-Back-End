require 'faker'
begin

    Patient.destroy_all
    Doctor.destroy_all
    Appointment.destroy_all
    Patient.destroy_all 
    Specialization.destroy_all
    
    prng = Random.new

    patients = Array.new(20) do
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,     
      password: "password"
    }
    end

    Patient.create(patients)

    specializations = [
    { name: 'Cardiology' },
    { name: 'Dermatology' },
    { name: 'Orthopedics' },
    { name: 'Ophthalmology' },
    { name: 'ENT' },
    { name: 'Endocrinology' },
    { name: 'Gastroenterology' },
    { name: 'Hematology' },
    { name: 'Neurology' },
    { name: 'Obstetrics and Gynecology' },
    { name: 'Oncology' },
    { name: 'Pediatrics' },
    { name: 'Psychiatry' },
    { name: 'Radiology' },
    { name: 'Urology' },
    { name: 'Rheumatology' },
    { name: 'Nephrology' },
    { name: 'Pulmonology' },
    { name: 'Hepatology' },
    { name: 'Emergency Medicine' },
    { name: 'Anesthesiology' },
    { name: 'Physical Medicine and Rehabilitation' },
    { name: 'Internal Medicine' },
    { name: 'Plastic Surgery' },
    { name: 'Vascular Surgery' },
    { name: 'Thoracic Surgery' },
    ]

    Specialization.create!(specializations)

    doctors = Array.new(20) do |index|
    {
      name: Faker::Name.name + ' (MD) ' + index.to_s,
      specialization:  specializations[prng.rand(1..20)]['name'],
      picture: 'https://picsum.photos/200/300',
      phone_number: Faker::PhoneNumber.cell_phone,
      time_start: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      time_end: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      specialization_id: Specialization.all.sample.id
    }
    end

    Doctor.create(doctors)
    
     appointments = Array.new(20) do
     {
      date_of_appointment: Faker::Date.between(from: '2023-01-01', to: '2023-12-31'),
      time_of_appointment: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      city: Faker::Address.city,
      doctor_id: prng.rand(1..20),
      patient_id: prng.rand(1..20)      
     }
     end
     Appointment.create(appointments)

     
  puts "Data Seeded."

rescue ActiveRecord::RecordInvalid => e
  puts "Validation error occurred: #{e.message}"
end