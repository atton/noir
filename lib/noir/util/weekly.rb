module Noir::Util::Weekly
  # utilities for calculation weeks

  TimeOfADay = (24 * 60 * 60)

  def end_of_week_separeted separator_day_of_week, week_diff
    check_method_name = "#{separator_day_of_week}?"
    unless Time.instance_methods(false).include?(check_method_name.to_sym)
      raise "a day of week name is incorrect! : #{separator_day_of_week}"
    end

    week_end = Time.now + (week_diff * 7 * TimeOfADay)
    week_end += TimeOfADay
    while !week_end.send(check_method_name)
      week_end += TimeOfADay
    end
    week_end - TimeOfADay
  end

  def begin_of_week_separeted separator_day_of_week, week_diff
    end_of_week_separeted(separator_day_of_week, week_diff) - (6*TimeOfADay)
  end
end
