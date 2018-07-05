class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
end
