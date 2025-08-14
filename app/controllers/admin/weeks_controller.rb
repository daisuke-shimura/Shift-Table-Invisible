class Admin::WeeksController < ApplicationController
  def index
    @week = Week.new
    @weeks = Week.all
  end

  def create
    @week = Week.new(week_params)
    if @week.save
      redirect_to admin_weeks_path, notice: 'Week was successfully created.'
    else
      @weeks = Week.all
      render :index, alert: 'Failed to create week.'
    end
  end

  def destroy
    @week = Week.find(params[:id])
    if @week.destroy
      redirect_to admin_weeks_path, notice: 'Week was successfully deleted.'
    else
      redirect_to admin_weeks_path, alert: 'Failed to delete week.'
    end
  end

  private
  def week_params
    params.require(:week).permit(:monday)
  end
end
