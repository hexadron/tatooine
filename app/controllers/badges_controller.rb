class BadgesController < ApplicationController
  respond_to :js, :html
  before_filter :load_badge
  
  def create
    @badge = Badge.create(params[:badge])
    if @badge.errors.empty?
      flash[:notice] = "Medalla creada correctamente"
    else
      flash[:alert] = format_errors(@badge)
    end
  end
  
  def show
    
  end
  

  private
  def load_badge
    @badge = Badge.find(params[:id]) if params[:id]
  end
end