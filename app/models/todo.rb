class Todo < ActiveRecord::Base
  belongs_to :project, :counter_cache => true
  belongs_to :user

  validates_presence_of :project

  validates_uniqueness_of :name, :scope => [:project_id]

end

# == Schema Information
#
# Table name: todos
#
#  id         :integer         not null, primary key
#  project_id :integer         indexed
#  user_id    :integer         indexed
#  name       :string(255)     not null, indexed
#  priority   :integer         default(0), not null, indexed
#  done       :boolean         default(FALSE), not null, indexed
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_todos_on_name        (name)
#  index_todos_on_done        (done)
#  index_todos_on_priority    (priority)
#  index_todos_on_user_id     (user_id)
#  index_todos_on_project_id  (project_id)
#

