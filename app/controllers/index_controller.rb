class IndexController < ApplicationController

  def index
  end

  def result
  end

  def action
    if current_user
      begin
        @origin, @target_list = Action.get_mutuals(current_user, params['target'])
      rescue Twitter::Error::Unauthorized
        redirect_to '/', alert: 'Cannot Run On Private Accounts'
      rescue  => e
        puts e.backtrace
        raise
        redirect_to '/', alert: 'Error Getting List'
      end
    else
      Rails.logger.info { 'Invalid Login' }
      redirect_to '/', alert: 'Invalid Login'
    end
  end

end
