module Admin::WeeksHelper

  def holiday_class(date)
    if Holidays.on(date, :jp).any?
      return 'text-danger'
    else
      return nil
    end
  end

end
