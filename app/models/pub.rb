class Pub < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  validates_presence_of :user
  validates_presence_of :project

  default_scope :order => 'created_at DESC'

  def before_validation
    self.head = self.body[0..200] + "..."
  end

  def preprocess
    # Links
    # "http://foo.com/user/thing/id" => "
    # <a href="http://foo.com/user/thing/id" class="codesolo-url web" rel="nofollow" target="_blank">http://foo.com/user...</a>

  end



  def parsed_text
    body
  end

  def before_save

  end


end


# == Schema Information
#
# Table name: pubs
#
#  id         :integer         not null, primary key
#  user_id    :integer         indexed
#  project_id :integer         indexed
#  head       :string(255)     not null, indexed
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_pubs_on_head        (head)
#  index_pubs_on_project_id  (project_id)
#  index_pubs_on_user_id     (user_id)
#

