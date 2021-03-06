require 'csv'
require 'erb'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_phone_number(phone_number)
  phone_number_digits = phone_number.scan(/\d/).join('')
  if phone_number_digits.length == 11 && phone_number_digits[0] == "1"
    phone_number_digits[1..11]
  elsif phone_number_digits.length == 10
    phone_number_digits
  else
    nil
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# template_letter = File.read "form_letter.erb"
#   erb_template = ERB.new template_letter
#   contents.each do |row|
#     id = row[0]
#     name = row[:first_name]
#
#     zipcode = clean_zipcode(row[:zipcode])
#
#     legislators = legislators_by_zipcode(zipcode)
#
#     form_letter = erb_template.result(binding)
#
#     save_thank_you_letters(id, form_letter)
#
#   end

# contents.each do |row|
#   phone_number = clean_phone_number(row[:homephone])
#   puts phone_number if phone_number
# end

# contents.map do |row|
#   DateTime.strptime(row[:regdate].to_s, "%m/%d/%y %H:%M")
# end.group_by do |date|
#   date.hour
# end


# contents.map do |row|
#   DateTime.strptime(row[:regdate].to_s, "%m/%d/%y %H:%M")
# end.group_by do |date|
#   date.wday
# end
