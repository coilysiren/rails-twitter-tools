class Action < ActiveRecord::Base

  belongs_to :user

  validates :target, presence: true
  validates_uniqueness_of :target, scope: :user

  def self.mute(user, target)
    Action.create!(user_id: user.id, target: target)
    TwitterClient.create_user(user).mute(target)
    return "Muted #{target}"
  rescue ActiveRecord::RecordInvalid
    return "Already muted that person!"
  end

  def self.get_mutuals(user, target)
    client = TwitterClient.create_user(user)
    origin_name = self.twitter_name(client.user.screen_name)
    target_name = self.twitter_name(target)
    target_info = client.user(target_name).to_h

    Follow.check_max_follows(client, origin_name)
    Follow.check_max_follows(client, target_name)

    origin_follows = Follow.get_follows(client, origin_name)
    target_follows = Follow.get_follows(client, target_name)

    mutuals = origin_follows & target_follows
    mutuals = self.get_info(client, mutuals)

    return target_info, mutuals
  end

  def self.get_info(client, id_list)
    key = Digest::MD5.hexdigest(id_list.to_s)
    status = "/get_info/#{key}"

    Rails.cache.fetch(status, expires_in: 1.days) do
      Rails.logger.info { status }
      user_list = client.users(id_list)
      user_list = (user_list).map { |user| user.to_h }
    end
  end

  def self.twitter_name(string)
    if string[0] == '@'
      return string
    else
      return '@' + string
    end
  end

end
