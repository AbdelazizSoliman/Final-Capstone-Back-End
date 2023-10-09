class Api::V1::AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]
  # GET /appointments
  def index
    @appointments = Appointment.all
    render json: @appointments
  end

  # GET /appointments/1
  def show
    render json: @appointment, status: :ok
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
      render json: { result: 'Appointment updated successfully' }
    else
      render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment = Appointments.find(params[:id])
     if @appointment.destroy
      render json: { data: 'Appointment deleted successfully', status: 'Success' }, status: :ok
    else
      render json: { data: 'Something went wrong', status: 'Failed' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:date_of_appointment, :time_of_appointment, :patient_id, :doctor_id, :city)
  end
end
