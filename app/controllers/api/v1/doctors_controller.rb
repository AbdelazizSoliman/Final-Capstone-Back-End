class Api::V1::DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show update destroy]
  # before_action :authenticate_patient!
  # before_action :authorize_admin, only: [:create, :destroy]

  # GET /doctors
  def index
    @doctors = Doctor.all.includes(:appointments)

    render json: @doctors
  end

  # GET /doctors/1
  def show
    @doctors = Doctor.all
    render json: @doctor
  end

  # POST /doctors
  def create
    @specialization = Specialization.find(params[:specialization_id])
    @doctor = @specialization.doctors.new(doctor_params)

    if @doctor.save
      render json: @doctor, status: :created
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

  # Use callbacks to share common setup or constraints between actions.
  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def doctor_params
    params.require(:doctor).permit(:name, :specialization, :picture, :price, :phone_number, :time_start, :time_end,
                                   @specialization.id)
  end

  def authorize_admin
    patient = current_patient
    patient_json = PatientSerializer.new(patient).as_json
    puts "Serialized Patient JSON: #{patient_json}"
    return if current_patient && current_patient.role == 'admin'

    render json: { error: 'Only admins can create doctors' }, status: :unauthorized
  end
end
