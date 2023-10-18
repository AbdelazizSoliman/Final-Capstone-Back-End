class Api::V1::PatientsController < ApplicationController
  # before_action :set_patient, only: %i[show update destroy]
  # before_action :authenticate_patient!, except: [:index, :show, :create]

  # GET /patient
  def index
    @patients = Patient.all.includes(:appointments)

    render json: @patients
  end

  # GET /patients/1
  def show
    render json: @patient
  end

  # POST /patient
  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      # render json: @patient, status: :created
      if @patient.valid?
        token = encode_token({ patient_id: @patient.id })
        render json: { patient: @patient, token: }, status: '200 OK'
      else
        render json: { error: 'failed to create patient' }, status: :unprocessable_entity
      end

    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def login
    patient = Patient.find_by(username: patient_params[:username])
    if patient
      token = encode_token({ patient_id: patient.id })
      render json: { token: }, status: '200 OK'
    else
      render json: { error: 'failed to create patient' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
  end

  # GET /patients/1/appointments
  def appointments
    @appointments = current_patient.appointments
    render json: @appointments
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def patient_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
