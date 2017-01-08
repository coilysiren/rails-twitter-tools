class Follow < ActiveRecord::Base

  def self.check_max_follows(client, target)
    if client.user(target).followers_count > 74900
      raise 'Too many followers'
    end
  end

  def self.get_follows(client, target)
    client_id = self.id_from_twitter_auth(client)
    status = "follows/source:#{client_id}/target:#{target}"

    Rails.cache.fetch(status, expires_in: 1.months) do
      Rails.logger.info { status }
      self.get_follows_page(client, target)
    end
  end

  def self.get_follows_page(client, target, fof: [], cursor: -1)
    client_id = self.id_from_twitter_auth(client)
    status = "follows/source:#{client_id}/target:#{target}/page:#{cursor}"

    Rails.cache.fetch(status, expires_in: 1.months) do
      Rails.logger.info { status }
      if cursor != 0
        response = client.friend_ids(target, :cursor => cursor).to_h
        self.get_follows_page(client, target,
          fof: fof + response[:ids],
          cursor: response[:next_cursor],
        )
      else
        return fof
      end
    end
  end

  def self.id_from_twitter_auth(cliet)
    cliet.access_token.split('-')[0].to_i
  end

end
