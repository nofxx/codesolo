class ProjectsController < ApplicationController

  before_filter :find_project
  before_filter :require_user, :only => [:destroy, :edit]

  def create
    @project = Project.new(params[:project])
    if @project.name && @project.url == ''
      @project.url = "http://github.com/#{current_user.login}/#{@project.name}"
    end
    respond_to do |format|
      if @project.save
        @project.binds.create(:user => current_user, :kind => :owner)
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to @project }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @project.destroy
        flash[:notice] = 'Project was successfully destroyed.'
        format.html { redirect_to projects_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Project could not be destroyed.'
        format.html { redirect_to @project }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @projects = Project.search(params[:page])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @projects }
    end
  end

  def edit
    redirect_to projects_path unless current_user.owns?(@project)
  end

  def watch
    respond_to do |format|
      if @project.binds.new(:user => current_user, :kind => :watch).save
        @project.up_karma!
      end
      format.html { redirect_to projects_path }
      format.xml  { render :xml => @project, :status => :created, :location => @project }
    end
  end

  def new
    @project = Project.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @project }
    end
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to @project }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_project
    @project = Project.find_by_name(params[:id]) if params[:id]
  end

  def require_user
    redirect_to "/" unless current_user
  end
end
