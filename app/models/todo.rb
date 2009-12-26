class Todo < ActiveRecord::Base
  belongs_to :project, :counter_cache => true
  belongs_to :user

  validates_presence_of :project


end
