class PubsController < ApplicationController

  def index
    @pubs = Pub.all

    respond_to do |format|
        format.html
    end
  end

  def create
    @pub = Pub.new(params[:pub])
    @pub.user = current_user

    respond_to do |format|
      if @pub.save
        format.html { redirect_to @pub.project }
        format.xml  { render :xml => @pub, :status => :created, :location => @project }
      else
        format.html { redirect_to @pub.project }
        # format.html { render :action => "new" }
        format.xml  { render :xml => @pub.errors, :status => :unprocessable_entity }
      end
    end
  end
end
