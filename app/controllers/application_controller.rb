require "application_responder"

class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  
  protected
  
  def load_types_for_select
    @types_for_select = ExerciseType.select([:id, :name]).map {|e| [I18n.t(e.name.to_sym), e.id] }
  end
end
