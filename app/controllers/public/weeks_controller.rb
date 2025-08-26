class Public::WeeksController < ApplicationController
  def index
    load_weeks
    load_calendar
  end


  private

  def load_weeks
    @weeks = Week.all
    @today = Date.today
    after_tommorow = Date.today + 2
    @weeks = Week.order(monday: :asc).where("monday > ?", after_tommorow)
  end

  def load_calendar
    earliest_date = @weeks.minimum(:monday)  # Date または nil
    latest_date   = @weeks.maximum(:monday) # Date または nil
    @start_date = earliest_date.beginning_of_month
    @end_date = latest_date.end_of_month

    week_by_start = @start_date.cwday # 週番号（1:月曜, 7:日曜）
    week_by_end   = @end_date.cwday
    start_day = @start_date - (week_by_start - 1)
    end_day   = @end_date - (week_by_end - 1)

    days = start_day.step(end_day, 7).to_a
    week_mondays = @weeks.index_by { |week| week.monday.to_date }
    @calendar_rows = days.map { |date| [date, week_mondays[date]] }
  end
end
