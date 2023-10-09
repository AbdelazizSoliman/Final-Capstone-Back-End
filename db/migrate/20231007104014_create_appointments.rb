class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.date :date_of_appointment
      t.time :time_of_appointment
      t.string :city
      t.timestamps
    end
  end
end
