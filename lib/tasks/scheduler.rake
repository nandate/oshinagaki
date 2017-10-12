desc "This task is called by the Heroku scheduler add-on"

require 'twitter'

task :tweet => :environment do
  puts "Getting tweets..."
  client = get_twitter_client
  crawl_tweet(client)
  puts "done."
end

def get_twitter_client

=begin
  config = {
    :consumer_key => ENV['TWITTER_KEY'],
    :consumer_secret => ENV['TWITTER_SECRET'],
    :access_token => ENV['TWITTER_ACCESS_TOKEN'],
    :access_token_secret => ENV['TWITTER_ACCESS_TOKEN_SECRET']
  }
=end
  config = {
    :consumer_key => Rails.application.secrets.twitter_key,
    :consumer_secret => Rails.application.secrets.twitter_secret,
    :access_token => Rails.application.secrets.twitter_access_token,
    :access_token_secret => Rails.application.secrets.twitter_access_token_secret
  }
  client = Twitter::REST::Client.new(config)
  client
end

def crawl_tweet(client)
  users = User.all
  users.each do |user|
    friend_list = client.friends(user.nickname)
    tweets = read_timeline(friend_list, client, user)
  end
end

def read_timeline(friend_list, client, user)
  friend_list.each do |friend|
    tweets = client.user_timeline(friend.screen_name)
    discern_tweet(tweets, user)
  end
end

def discern_tweet(tweets, user)
  pattern = /(お品書き|おしながき|お品がき|おしな書き)/
  now_time = Time.now
  tweets.each do |tweet|
    tweet.media.flat_map do |m|
      case m
      when Twitter::Media::Photo
        if pattern =~ tweet.text && now_time - tweet.created_at < 60 * 60
          puts tweet.created_at
          user.menus.create(content: tweet.text,author: tweet.user.name,image_url: m.media_url.to_s)
        end
      end
    end
  end
end
