class EstimatesController < ApplicationController

  def show
    @estimate = Estimate.find(params[:id])
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
  end

  private
    def estimate_params
      params.require(:estimate).permit(:name,:term)
    end
end
