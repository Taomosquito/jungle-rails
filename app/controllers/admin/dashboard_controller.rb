class Admin::DashboardController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :authenticate
  
  def show
  end

  private

  def authenticate
    self.class.http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  end
end
