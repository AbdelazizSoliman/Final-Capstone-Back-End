class Api::V1::AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]
  # before_action :authenticate_patient!

  # GET /appointments
  def index
    @appointments = Appointment.includes(doctor: :specialization).all
    appointment_data = @appointments.map do |appointment|
      {
        id: appointment.id,
        date_of_appointment: appointment.date_of_appointment,
        time_of_appointment: appointment.time_of_appointment,
        city: appointment.city,
        doctor_name: appointment.doctor.name,
        patient_name: appointment.patient.name
      }
    end

    render json: appointment_data
  end

  def doctors_patients
    sql_query = "SELECT appointments.id, appointments.date_of_appointment, appointments.time_of_appointment,
                appointments.city, doctors.name AS doctor_name, patients.name AS patient_name
                 FROM appointments
                 JOIN doctors ON appointments.doctor_id = doctors.id
                 JOIN patients ON appointments.patient_id = patients.id"

    @results = ActiveRecord::Base.connection.execute(sql_query)
    render json: @results
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: { errors: @appointment.errors.full_messages, status: 'Failed' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    @appointment = Appointments.find(params[:id])
    if @appointment.update(appointment_params)
      render json: @appointment, status: :ok
    else
      render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    if @appointment.destroy
      render json: { data: 'Appointment deleted successfully', status: 'Success' }, status: :ok
    else
      render json: { data: 'Something went wrong', status: 'Failed' }
    end
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:date_of_appointment, :time_of_appointment, :city, :doctor_id, :patient_id)
  end
end
