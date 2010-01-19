class HomeController < ApplicationController

  #skip_before_filter :require_user

  # current_user atualizations....
  def index
    @projects = Project.search(1)
    @tags = Tag.all
  end

  def profile
    if @user = User.find_by_login(params[:login])
      @projects = @user.projects
    elsif @tag = Tag.find_by_name(params[:login])
    elsif @project = Project.find_by_name(params[:login])
      redirect_to @project
    end
  end


  def location
    render :text => { :update => current_user.update_location(params) }
  end

  # poor's man search
  def search
    @projects = Project.search(params[:page], params[:q])
    tags = params[:q].split(/\s/).map { |k| Tag.find_by_name(k) }.reject(&:nil?)
    @projects << tags.map { |tag| tag.projects }
    @projects.flatten!
  end

  def sendmail
    if UserMailer.deliver_send_to_friend(params[:name] || current_user.name, params[:email], params[:project])
      redirect_to "/projects/#{params[:project]}"
    end
  end

end
