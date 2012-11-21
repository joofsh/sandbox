#dependencies
require "csv"
require 'sunlight'
require 'pry'

#Class Definition
class EventManager
  INVALID_ZIPCODE = "00000"
  INVALID_PHONE = "0000000000"
  Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"
  FileUtils.mkdir_p 'output'

  #initializes input file, a list of attendees to an event
  def initialize(filename)
    puts "EventManager Initialized."
    @file = CSV.open(filename, {:headers => true, :header_converters => :symbol })
  end

  #prints names of all attendees
  def print_names
    @file.each do |line|
      puts "#{line[:first_name]} #{line[:last_name]} "
    end
  end

  #prints phone numbers of all attendees
  def print_numbers
    @file.each do |line|
      number = clean_numbers(line[:homephone])
       puts number
      end

  end

  #manipulates numbers to 10 digit format w/o dashes or spaces
  def clean_numbers(original)
      number = original.delete("()-. ")

      if number.length == 10

      elsif number.length == 11
        if number.start_with?("1")
          number = number[1..-1]
        else
          number = INVALID_PHONE
        end

      else
        number = INVALID_PHONE
      end
      return number
  end

  #manipulates zipcodes to 5 digit format to include starting zeros
  def clean_zipcodes(original)
      zipcode = "#{INVALID_ZIPCODE}#{original}"
     zipcode = zipcode[-5..-1]
    return zipcode
  end

  #prints zipcodes of all attendees
  def print_zipcodes
    @file.each do |line|
      zipcode =  clean_zipcodes(line[:zipcode])
      puts zipcode
    end
  end

  #outputs data to CSV file with cleaned zipcodes and phone numbers
  def output_data(filename)
    output = CSV.open(filename, "w")
    @file.each do |line|
      if @file.lineno == 2
        output << line.headers
      else
        line[:homephone] = clean_numbers(line[:homephone])
        line[:zipcode] = clean_zipcodes(line[:zipcode])
        output << line
      end

    end
  end

  #Accesses sunlight API to determine representative based on zipcode
  #Prints representative for each attendees (Needs to be refactored)
  def rep_lookup
    20.times do
      line = @file.readline

      representative = "unknown"
      #API lookup goes Here
      legislators = Sunlight::Legislator.all_in_zipcode(clean_zipcodes(line[:zipcode]))
      names = legislators.collect do |leg|
        first_name = leg.firstname
        first_initial = first_name[0]
        last_name = leg.lastname
        party = leg.party
        party_initial = party[0]
        title = leg.title
        title_abbr = title[0..2]
        title_abbr +" "+ first_initial + ". " + last_name +" ("+party_initial+")"
      end

      puts "#{line[:last_name]}, #{line[:last_name]}, #{line[:zipcode]}, #{names.join(", ")}"
    end
  end

  #Creates custom HTML thank you letters based on attendees contact info
  #If implemented, would change 20.times to length of attendees list
  def create_form_letters
    letter = File.open("form_letter.html", "r").read
    @file.seek 0
      20.times do
      #binding.pry
      line = @file.readline
      custom_letter = letter.gsub("#first_name", "#{line[:first_name]}")
      custom_letter = custom_letter.gsub("#last_name","#{line[:last_name]}")
      custom_letter = custom_letter.gsub("#street", "#{line[:street]}")
      custom_letter = custom_letter.gsub("#city", "#{line[:city]}")
      custom_letter = custom_letter.gsub("#state", "#{line[:state]}")
      custom_letter = custom_letter.gsub("#zipcode", "#{line[:zipcode]}")

      filename = "output/thanks_#{line[:last_name]}_#{line[:first_name]}.html"
      output = File.open(filename, "w")
      output.write(custom_letter)
    end
  end

  #Collects and prints data on which hours of the day attendees registered
  def rank_times
    hours = Array.new(24){0}
    @file.each do |line|
      hour = line[:regdate].split(" ")
      hour = hour[1].split(":")
      hours[hour[0].to_i] += 1

    end
     hours.each_with_index{ |counter,hours| puts "#{hours}: #{counter}"}
  end

  #Collects and prints data on which days of the week attendees registered
  def day_stats
    days = Array.new(7){0}
    @file.each do |line|
      date = line[:regdate].split(" ")
      date = Date.strptime(date[0],"%m/%d/%y")
    days[date.wday.to_i] += 1
    end
    days.each_with_index{ |counter, days| puts "#{days}: #{counter}"}

  end

  #Collects and prints data on number of attendees by state
  def state_stats
    state_data = {}
    @file.each do |line|
      state = line[:state]
      if state_data[state].nil?
        state_data[state] = 1
      else
        state_data[state] += 1
      end

    end
      rank = state_data.sort_by{|state, counter| -counter}.collect{|state,counter| state unless state.nil?}
      state_data = state_data.select{|state, counter| state}.sort_by{|state,counter| state unless state.nil?}
      state_data.each do |state, counter|
        puts "(#{rank.index(state)+1}) #{state}: #{counter}"
      end
  end

  def test
    letter = File.open("form_letter.html", "r").read
    puts letter
    20.times do
      line = @file.readline
      puts line
    end
  end
end

# Script
manager = EventManager.new("event_attendees.csv")
manager.output_data("event_attendees_cleaned.csv")

manager.create_form_letters

#manager.test