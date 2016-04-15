class Action < ActiveRecord::Base

  belongs_to :user

  validates :target, presence: true

  def self.mute(user, target)
    Action.create('user': user, 'target': target)
    TwitterClient.create_user(user).mute(target)
  end

end
