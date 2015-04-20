require 'csv'

def clean_zipcode(zip)
  zip.to_s.rjust(5, "0")[0..4]
end

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zip = clean_zipcode(row[:zipcode])


  puts "#{name} and #{zip}"
end
