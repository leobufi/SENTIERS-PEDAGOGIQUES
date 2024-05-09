class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  @generals = General.all

end
