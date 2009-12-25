class Tag < ActiveRecord::Base

  has_many :taggings

  validates_presence_of :name

  # im sure there a better way
  def projects
    taggings.all(:conditions => { :taggable_type => :Project}).map(&:taggable)
  end

  def up!

  end

end
