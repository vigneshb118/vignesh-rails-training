class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :company_already_exists, only: [:new, :create]
  before_action :set_company, only: [:show, :edit, :update]
  before_action :authorize_company, only: [:show, :edit, :update]

  def show
  end

  def new
    authorize Company
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    if @company.save
      redirect_to @company, notice: "Company created successfully"
    else
      flash.now[:alert] = "Failed to create company: #{@company.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company updated successfully"
    else
      flash.now[:alert] = "Failed to update company: #{@company.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description)
  end

  def authorize_company
    authorize @company
  end

  def company_already_exists
    if current_user.company.present?
      redirect_to company_path(current_user.company), alert: "You already have a company"
    end
  end
end
