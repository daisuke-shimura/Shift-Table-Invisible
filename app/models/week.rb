class Week < ApplicationRecord

  def month
    monday.month
  end

  def sunday
    monday + 6
  end

  def tuesday
    monday + 1
  end

  def wednesday
    monday + 2
  end

  def thursday
    monday + 3
  end

  def friday
    monday + 4
  end

  def saturday
    monday + 5
  end


end
