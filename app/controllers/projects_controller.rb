class ProjectsController < ApplicationController

  before_filter :find_project


  def create
    @project = Project.new(params[:project])
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
    @project = Project.find(params[:id]) if params[:id]
  end

end
