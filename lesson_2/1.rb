require "date"

COMMON_YEAR_DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

months_hash = {}

Date::MONTHNAMES.compact.each_with_index do |month, i|
  if i == 1
    months_hash[month] = [28, 29]
  else
    months_hash[month] = COMMON_YEAR_DAYS_IN_MONTH[i]
  end
end

months_hash.each { |month, days| puts month if days == 30 }
