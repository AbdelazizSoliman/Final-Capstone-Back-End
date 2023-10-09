class AddDoctorAndPatientToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :doctor, foreign_key: true, null: false
    add_reference :appointments, :patient, foreign_key: true, null: false
  end
end
