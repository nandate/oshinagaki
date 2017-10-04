desc "This task is called by the Heroku scheduler add-on"

require 'twitter'

task :tweet => :environment do
  puts "Getting twitter..."
  client = get_twitter_client
  crawl_tweet(client)
  puts "done."
end

def get_twitter_client
  config = {
    :consumer_key => ENV['TWITTER_KEY'],
    :consumer_secret => ENV['TWITTER_SECRET'],
    :access_token => ENV['TWITTER_ACCESS_TOKEN'],
    :access_token_secret => ENV['TWITTER_ACCESS_TOKEN_SECRET']
  }
  client = Twitter::REST::Client.new(config)
  client
end

def crawl_tweet(client)
  @user = User.all
  @user.each do |user|
    friend_list = client.friends(user.nickname)
    read_timeline(friend_list, client)
  end
end

def read_timeline(friend_list, client)
  friend_list.each do |friend|
    tweets = client.user_timeline(friend.screen_name)
    puts tweets
  end
end
