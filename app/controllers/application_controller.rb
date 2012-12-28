require "application_responder"

class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
end
