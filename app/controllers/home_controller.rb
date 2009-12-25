class HomeController < ApplicationController

  #skip_before_filter :require_user

  # current_user atualizations....
  def index
    @all = Project.search(1)
    @first = @all.delete_at(0)
  end

  def profile
    @user = User.find_by_login(params[:login])
  end


  def location
    render :text => { :update => current_user.update_location(params) }
  end

  def search

  end

end
