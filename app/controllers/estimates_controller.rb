class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]

  def new
    @estimate = Estimate.new
  end


  def show
  end

  def edit
  end

  def update
    @estimate.update(estimate_params)
    redirect_to current_user
  end

  def create
    @estimate = current_user.estimates.build(estimate_params)
    if @estimate.save
      redirect_to current_user
    else
      render json: @estimate.errors, status: 422
    end
  end

  def destroy
    @estimate.destroy
    redirect_to current_user
  end

  private
    def set_estimate
      @estimate = Estimate.find(params[:id])
    end

    def estimate_params
      params.require(:estimate).permit(:name,:term)
    end
end
