class Admin::WeeksController < ApplicationController
  def index
    @week = Week.new
    @weeks = Week.all

    #カレンダー
    today = Date.today
    start_date = today.beginning_of_month
    end_date = today.end_of_month
    # 月曜始まりに揃える
    start_date -= (start_date.wday - 1) % 7

    # 日曜終わりに揃える
    end_date += (7 - end_date.wday) % 7

    @days = (start_date..end_date).to_a
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
