require "rubygems"
require "bundler/setup"
require 'jumpstart_auth'
require 'pry'
require 'bitly'
require 'klout'

class JSTwitter
  attr_reader :client

  def initialize
    puts "Initializing"
    @client = JumpstartAuth.twitter
    Klout.api_key = ENV['8y4gv4ebrb3uxumy3y8raf78']
   # klout_id = Klout::Identity.find_by_twitter_id('jdpagano')
   #  user = Klout::Identity.new(klout_id)
    #binding.pry
  end

  #starts the program. Accepts commands to message, tweet, or quit program
  def run
    puts "Welcome to the Twitter Client"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp.split(" ")
      command = input[0]

      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(input[1..-1].join(" "))
        when 'dm' then dm(input[1],input[2..-1].join(" "))
        when 'spam' then spam_my_friends(input[1..-1].join(" "))
        when "lt" then everyones_last_tweet()
        when "s"  then shorten(input[1])
        when 'turl' then tweet("#{input[1..-2].join(" ")}: #{shorten(input[-1])}")
        else
          puts "Sorry, I dont know how to #{command}"
      end
    end
  end

  #sends a tweet of 140 or less chars
  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Warming, your messages is over the limit. Only 140 characters max"
    end
  end
  # returns an array of all user's followers
  def followers_list
    screen_names = @client.followers.collect{|follower| follower.screen_name}
  end

  def friends_list
    friends = @client.friends.collect{|friend| friend.screen_name}
  end


  #verifies that a user is following you
  def ver_fol(target)
    ver = false
    screen_names = followers_list
    screen_names.each do
      if screen_names.include? target
        ver = true
      end
    end
  end

  #sends a direct message to all of user's followers
  def spam_my_friends(message)
    screen_names = followers_list
    screen_names.each do |name|
      dm(name,message)
    end
  end

  #Checks if user is following you, then call tweet to send them a direct message
  def dm(target,message)
    mes_string = "d #{target} #{message}"
    puts "Trying to send #{target} this direct message:"
    puts message

    if ver_fol(target)
      tweet(mes_string)
      puts "Success!"

    else
      puts "Sorry. You can not direct message someone who is not a follower"
    end
  end

  def everyones_last_tweet
    friends_array = @client.friends
    friends_array.sort_by{ |friend| friend.screen_name.downcase}.each do |friend|
      puts "#{friend.screen_name} said on #{friend.status.created_at.strftime("%A, %b %d")}:"
      puts "#{friend.status.text}"
      puts ""
    end
  end

  # Takes original URL and using bitly API to shorten it
  def shorten(original)
    Bitly.use_api_version_3
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    new_url = bitly.shorten(original).short_url
    puts "Shortening this URL: #{original}"
    puts "New URL: #{new_url}"
    return new_url
  end

  def friends_klout
    array = friends_list
   #
    # puts user = Klout::User.details
    #binding.pry
    array.each do |screen_name|

   # puts "#{screen_name}'s Klout: #{@k.klout(screen_name)["users"][0]["kscore"]}"
    end
  end

end


jst = JSTwitter.new

#jst.run


jst.friends_klout

