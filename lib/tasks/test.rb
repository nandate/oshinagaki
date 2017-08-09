require "#{Rails.root}/app/models/user"

class Tasks::Test
  def self.test
    config = {
      :consumer_key => ENV['TWITTER_KEY'],
      :consumer_secret => ENV['TWITTER_SECRET'],
      :access_token => ENV['TWITTER_ACCESS_TOKEN'],
      :access_token_secret => ENV['TWITTER_ACCESS_TOKEN_SECRET']
    }

    user = User.find(1)
    client = Twitter::REST::Client.new(config)
    tweets = client.home_timeline
    tweets.each do |tweet|
      if tweet.text.index("お品書き")
        tweet.media.flat_map do |m|
          case m
          when Twitter::Media::Photo
            puts m.media_url.to_s
            user.menus.create(content: tweet.text,author: tweet.user.name,image_url: m.media_url.to_s)
          else
          end
        end
      end
    end

  end
end
