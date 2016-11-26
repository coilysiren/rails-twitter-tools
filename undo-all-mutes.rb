for mute in Action.all()
  client = TwitterClient.create_user(mute.user)
  client.unmute(mute.target)
  mute.delete()
end
