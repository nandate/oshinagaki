require "#{Rails.root}/app/models/user"

class Tasks::Test
  def self.test
    users = User.all
    users.each do |user|
      puts user.provider
    end
  end
end
