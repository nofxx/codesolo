class Tagging < ActiveRecord::Base
  belongs_to :tag, :counter_cache => true
  belongs_to :taggable, :polymorphic => true

  validates_uniqueness_of :tag_id, :scope => [:taggable_type, :taggable_id]
end
