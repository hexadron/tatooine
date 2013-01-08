# encoding: utf-8

class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:show]
  before_filter :load_user, only: [:edit, :update, :show, :course_stats]
  before_filter :check_user, only: [:edit, :update, :course_stats]
  
  def show
    @courses_you_take = @user.courses
    @courses_you_teach = @user.creations
  end
  
  def edit
    
  end
  
  def course_stats
    load_course
    render layout: 'show_course'
  end
  
  def update
    if params[:user]
      if params[:user][:avatar]
        @user.update_attributes(params[:user])
        flash[:notice] = "Imagen actualizada"
        redirect_to edit_user_url(@user)
        return
      end
      
      if @user.valid_password?(params[:user][:old_password])
        if @user.update_attributes(params[:user])
          sign_in @user, :bypass => true
          flash[:notice] = "Contraseña actualizada"
          redirect_to edit_user_url(@user)
        else
          flash[:errors] = @user.errors.full_messages.to_sentence
          redirect_to edit_user_url(@user)
        end
      else
        flash[:alert] = "Contraseña inválida"
        redirect_to edit_user_url(@user)
      end
    else
      flash[:alert] = "Imagen no seleccionada"
      redirect_to edit_user_url(@user)
    end
  end
  
  private
  
  def load_course
    @course ||= Course.find(params[:course_id])
  end
  
  def load_user
    @user ||= User.find(params[:id])
  end
  
  def check_user
    load_user
    if !current_user or current_user.id != @user.id
      redirect_to '/404.html'
    end
  end
  
end