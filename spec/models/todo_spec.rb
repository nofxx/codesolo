require 'spec_helper'

describe Todo do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Todo.create!(@valid_attributes)
  end
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

