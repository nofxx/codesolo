class TagsController < ApplicationController

  before_filter :require_admin

  def index
    @tags = Tag.paginate(:page => params[:page])
  end


end
