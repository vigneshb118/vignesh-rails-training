class JobsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_job, only: [ :show, :edit, :update, :destroy, :change_status, :apply, :cancel_application ]
  before_action :set_job_application, only: [ :show ]
  before_action :authorize_job, only: [ :edit, :update, :destroy, :apply, :cancel_application ]

  def index
    @jobs = Job.open.order(:id)
  end

  def show
  end

  def new
    authorize Job
    @job = Job.new
  end

  def create
    authorize Job
    @job = Job.new(job_params)
    @job.company = current_user.company
    if @job.save
      redirect_to jobs_path, notice: "Job created successfully"
    else
      flash.now[:alert] = "Failed to create job: #{@job.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, notice: "Job updated successfully"
    else
      flash.now[:alert] = "Failed to update job: #{@job.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status
    if @job.update(job_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render :change_status_error, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @job.destroy
      redirect_to jobs_path, notice: "Job deleted successfully"
    else
      redirect_to jobs_path, alert: "Failed to delete job"
    end
  end

  def apply
    @job_application = JobApplication.new(job_id: @job.id, user_id: current_user.id)
    if params[:job_application] && params[:job_application][:resume].present?
      @job_application.resume.attach(params[:job_application][:resume])
    end
    if @job_application.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render :apply_error, status: :unprocessable_entity }
      end
    end
  end
  
  def cancel_application
    @job_application = JobApplication.find_by(job_id: @job.id, user_id: current_user.id)
    if @job_application&.destroy
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render :cancel_application_error, status: :unprocessable_entity }
      end
    end
  end  

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :job_type, :salary, :status)
  end

  def authorize_job
    authorize @job
  end

  def set_job_application
    @job_application = @job.job_applications.find_by(user_id: current_user.id)
  end
end
