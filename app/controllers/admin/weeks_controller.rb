class Admin::WeeksController < ApplicationController
  def index
    @week = Week.new
    after_tommorow = Date.today + 2
    @weeks_all = Week.all
    # @weeks = Week.order(monday: :asc)
    @weeks = Week.order(monday: :asc).where("monday > ?", after_tommorow)
    earliest = @weeks.first   # monday が最小の Week オブジェクト
    latest   = @weeks.last    # monday が最大の Week オブジェクト
    earliest_date = @weeks.minimum(:monday)  # Date または nil
    latest_date   = @weeks.maximum(:monday) # Date または nil
    #@week_mondays = @weeks.map { |w| w.monday.to_date }        # 判定用の配列
    @week_mondays = @weeks.index_by { |week| week.monday.to_date }


    #カレンダー
    @today = Date.today + 30
    #@start_date = @today.beginning_of_month
    @start_date = earliest_date.beginning_of_month
    @end_date = latest_date.end_of_month
    @week_by_start = @start_date.cwday # 週番号（1:月曜, 7:日曜）
    @week_by_end   = @end_date.cwday
    @start_day = @start_date - (@week_by_start - 1)
    @end_day   = @end_date - (@week_by_end - 1)
    # @days = (start_day..(start_day + 29)).to_a
    # @days = @start_day.step(@start_day + 49, 7).to_a # 月曜始まりで7日ごとに取得
    @days = @start_day.step(@end_day, 7).to_a

    weeks_count = 5 # 表示する週数を指定
    @calendar_weeks = (0...weeks_count).map do |i|
      monday = @start_day + i * 7
      (0..6).map { |d| (monday + d).to_date }  # 各週の月〜日を Date 配列で返す
    end
    # end_date = today.end_of_month
    # # 月曜始まりに揃える
    # start_date -= (start_date.wday - 1) % 7

    # # 日曜終わりに揃える
    # end_date += (7 - end_date.wday) % 7

    # @days = (start_date..end_date).to_a
    @calendar_rows = @days.map { |date| [date, @week_mondays[date]] }
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
