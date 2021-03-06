class User < ApplicationRecord
  has_many :menus, dependent: :destroy
  has_many :estimates, dependent: :destroy

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    nickname = auth[:info][:nickname]
    image_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
    end
  end

  def feed
    Menu.where("user_id=?", id)
  end

  def estimates_feed
    Estimate.where("user_id=?", id)
  end

end
