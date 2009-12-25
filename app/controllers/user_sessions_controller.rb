# -*- coding: utf-8 -*-
class UserSessionsController < ApplicationController
  skip_before_filter :require_user, :only => [:new, :create]

  def new
   # @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Bem vindo #{@user_session.user.name}!"
      redirect_back_or_default "/" #account_url
    else
      render :action => :new
    end
  end

  def destroy
    flash[:notice] = "Até mais #{current_user.name}!"
    current_user_session.destroy
    redirect_back_or_default "/" #new_user_session_url
  end
end
