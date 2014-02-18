module BusesHelper
  
  def day_name_from_number(num)
    case num
    when 0
      return "Monday"
    when 1
      return "Tuesday"
    when 2
      return "Wednesday"
    when 3
      return "Thursday"
    when 4
      return "Friday"
    when 5
      return "Saturday"
    when 6
      return "Sunday"
    else
      return ""
    end
  end
  
end
