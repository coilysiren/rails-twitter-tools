for mute in Action.all()
  begin
    client = TwitterClient.create_user(mute.user)
    client.unmute(mute.target)
    mute.delete()
  rescue NoMethodError, Twitter::Error::Forbidden, Twitter::Error::Unauthorized, Twitter::Error::NotFound
    nil
  end
end
