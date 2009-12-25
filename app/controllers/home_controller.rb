class HomeController < ApplicationController

  #skip_before_filter :require_user

  # current_user atualizations....
  def index
    @all = Project.search(1)
    @first = @all.delete_at(1)
    @tags = Tag.all
  end

  def profile
    if @user = User.find_by_login(params[:login])
    elsif @tag = Tag.find_by_name(params[:login])
    elsif @project = Project.find_by_name(params[:login])
      redirect_to @project
    end
  end


  def location
    render :text => { :update => current_user.update_location(params) }
  end

  def search

  end

end
