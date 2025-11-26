module Companies
    class JobApplicationsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_company
        before_action :set_job

        def index
            @job_applications = @job.job_applications
        end

        private

        def set_company
            @company = Company.find(params[:company_id])
        end

        def set_job
            @job = Job.find(params[:job_id])
        end
    end
end
