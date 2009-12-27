class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  # im sure there a better way
  def projects
    taggings.all(:conditions => { :taggable_type => :Project}).map(&:taggable)
  end

  def before_validation
    self.name = name.downcase if name

  end

  def count
    taggings.count
  end

end

# == Schema Information
#
# Table name: tags
#
#  id             :integer         not null, primary key
#  name           :string(255)     not null, indexed
#  taggings_count :integer         default(0), not null, indexed
#
# Indexes
#
#  index_tags_on_taggings_count  (taggings_count)
#  index_tags_on_name            (name)
#

