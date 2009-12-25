# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]

  def index
    @users = User.paginate :page => params[:page]
  end

  # render new.rhtml
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "Usuário criado!"
      redirect_back_or_default @user
    else
      flash[:error]  = "Erro ao atualizar usuário."
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Usuário atualizado!"
      redirect_to @user
    else
      render :action => :edit
    end
  end

  def fetch
    @user = User.find(params[:id])
    @user.fetch_me

    respond_to do |format|
      format.html { redirect_to(@user) }
      format.xml  { head :ok }
    end

  end

  def fetch_all
    User.fetch_all

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end

  end

  def suspend
    @user.suspend!
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend!
    redirect_to users_path
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def purge
    @user.destroy!
    redirect_to users_path
  end

  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
