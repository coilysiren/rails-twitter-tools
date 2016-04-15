class IndexController < ApplicationController

  def index
  end

  def mute
    if current_user
      target = params['target']
      Action.mute(current_user, target)
      redirect_to '/', notice: "Muted #{target}"
    else
      redirect_to '/', notice: 'Invalid Login'
    end
  end

end
