module Companies
    class JobApplicationsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_company
        before_action :set_job, only: [ :index ]
        before_action :set_job_application, only: [ :update ]

        def index
            @job_applications = @job.job_applications.includes(:user)
        end

        def update
            authorize @job_application
            if @job_application.update(job_application_params)
                respond_to do |format|
                    format.turbo_stream
                    format.html { redirect_to company_job_applications_path(@company, job_id: @job_application.job_id), notice: "Application status updated" }
                end
            else
                respond_to do |format|
                    format.turbo_stream { render :index, status: :unprocessable_entity }
                    format.html do
                        flash.now[:alert] = "Failed to update application: #{@job_application.errors.full_messages.join(', ')}"
                        render :index, status: :unprocessable_entity
                    end
                end
            end
        end

        private

        def set_company
            @company = Company.find(params[:company_id])
        end

        def set_job
            @job = Job.find_by(id:params[:job_id])
        end

        def set_job_application
            @job_application = JobApplication.find(params[:id])
        end

        def job_application_params
            params.require(:job_application).permit(:status)
        end
    end
end
