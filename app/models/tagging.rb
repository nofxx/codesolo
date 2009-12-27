class Tagging < ActiveRecord::Base
  belongs_to :tag, :counter_cache => true
  belongs_to :taggable, :polymorphic => true

  validates_uniqueness_of :tag_id, :scope => [:taggable_type, :taggable_id]
end

# == Schema Information
#
# Table name: taggings
#
#  id            :integer         not null, primary key
#  tag_id        :integer         not null, indexed
#  taggable_id   :integer         indexed => [taggable_type]
#  taggable_type :string(255)     indexed => [taggable_id]
#
# Indexes
#
#  index_taggings_on_taggable_id_and_taggable_type  (taggable_id,taggable_type)
#  index_taggings_on_tag_id                         (tag_id)
#

