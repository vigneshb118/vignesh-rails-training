class JobsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_job, only: [ :show, :edit, :update, :destroy, :change_status, :apply ]
  before_action :authorize_job, only: [ :edit, :update, :destroy, :apply ]

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
    if @job.save!
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit
    end
  end

  def change_status
    @job.update(job_params)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
  end

  def apply
    @job_application = JobApplication.new(job_id: @job.id, user_id: current_user.id)
    if @job_application.save!
      redirect_to job_path(@job)
    else
      render :show
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
end
