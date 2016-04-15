class Action < ActiveRecord::Base

  belongs_to :user

  validates :target, presence: true
  validates_uniqueness_of :target, scope: :user

  def self.mute(user, target)
    Action.create!('user': user, 'target': target)
    TwitterClient.create_user(user).mute(target)
    return "Muted #{target}"
  rescue ActiveRecord::RecordInvalid
    return "Already muted that person!"
  end

end
