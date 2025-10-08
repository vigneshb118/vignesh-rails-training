class JobsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_job, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_job, only: [ :edit, :update, :destroy ]

  def index
    @jobs = Job.all
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
      redirect_to @job, notice: "Job created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: "Job updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: "Job deleted successfully"
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :job_type, :salary)
  end

  def authorize_job
    authorize @job
  end
end
