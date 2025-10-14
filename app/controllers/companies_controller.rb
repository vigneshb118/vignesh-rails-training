class CompaniesController < ApplicationController
  before_action :authenticate_user!
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
    if @company.save!
      redirect_to @company
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update!(company_params)
      redirect_to @company
    else
      render :edit
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
end
