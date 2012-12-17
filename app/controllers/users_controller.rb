# encoding: utf-8

class UsersController < ApplicationController
  
  def edit
    
  end
  
  def update
    @user = User.find(params[:id])

    if params[:user][:avatar]
      @user.update_attributes(params[:user])
      flash[:notice] = "Imagen actualizada"
      redirect_to edit_user_url(@user)
    end
    
    if @user.valid_password?(params[:user][:old_password])
      flash[:notice] = "Contraseña inválida"
      redirect_to edit_user_url(@user)
    else
      if @user.update_attributes(params[:user])
        sign_in @user, :bypass => true
        flash[:notice] = "Contraseña actualizada"
      else
        flash[:errors] = @user.errors.full_messages.to_sentence
        redirect_to edit_user_url(@user)
      end
    end
  end
  
  def show
    
  end
  
end