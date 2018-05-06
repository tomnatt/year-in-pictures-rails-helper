class DateService
  def self.define_last_month
    # Return this month if we're past 20th of the month
    return Date.current.month if Date.current.day > 20
    # Months run 1..12 - return Dec if we're in Jan
    Date.current.month > 1 ? Date.current.month - 1 : 12
  end

  def self.year_for_last_month
    # Return this year unless we in early Jan, in which case return last year
    return Date.current.year unless define_last_month == 12 && Date.current.month == 1
    Date.current.year - 1
  end
end
