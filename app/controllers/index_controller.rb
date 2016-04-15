class IndexController < ApplicationController

  def index
  end

  def mute
    if current_user
      target = params['target']
      message = Action.mute(current_user, target)
      redirect_to '/', notice: message
    else
      redirect_to '/', notice: 'Invalid Login'
    end
  end

end
