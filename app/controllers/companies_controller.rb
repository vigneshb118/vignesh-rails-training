class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_path, notice: "Company deleted successfully"
  end

  private
  
  def set_company
    @company = current_user.company
  end

  def company_params
    params.require(:company).permit(:name, :description)
  end
end
