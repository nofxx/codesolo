class Bind < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates_presence_of :user, :project
  validates_uniqueness_of :user_id, :scope => [:project_id, :kind]

  symbolize :kind, :in => [:watch, :owner, :dev]

end

# == Schema Information
#
# Table name: binds
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null, indexed, indexed => [project_id]
#  project_id :integer         not null, indexed, indexed => [user_id]
#  kind       :string(255)     default("watch"), not null
#
# Indexes
#
#  index_binds_on_project_id              (project_id)
#  index_binds_on_user_id                 (user_id)
#  index_binds_on_user_id_and_project_id  (user_id,project_id)
#

