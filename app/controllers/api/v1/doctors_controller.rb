require 'pry'
class Api::V1::DoctorsController < ApplicationController
 
  # GET /doctors
  def index
    @doctors = Doctor.all.includes(:appointments, :specialization)
      .order('doctors.created_at DESC')

    render json: @doctors
  end

  # GET /doctors/1
  def show
    @doctor = Doctor.joins(:specialization)
      .select('doctors.*', 'specializations.name AS specialization_name')
      .find_by(id: params[:id])
    render json: @doctor
  end

  # POST /doctors
  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      index     
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor = Doctor.find_by(id: params[:id])
    if @doctor
      if @doctor.destroy
        render json: { message: 'Doctor was successfully destroyed' }, status: :ok
      else
        render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Doctor not found' }, status: :not_found
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def doctor_params
    params.require(:doctor).permit(:name, :picture, :price, :phone_number, :time_start, :time_end,
                                   :specialization_id)
  end

  def authorize_admin
    patient = current_patient
    patient_json = PatientSerializer.new(patient).as_json
    puts "Serialized Patient JSON: #{patient_json}"
    return if current_patient && current_patient.role == 'admin'

    render json: { error: 'Only admins can create doctors' }, status: :unauthorized
  end
end
