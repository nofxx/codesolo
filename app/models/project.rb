class Project < ActiveRecord::Base

  PROJECTS_PER_PAGE = 20

  has_many :binds
  has_many :users, :through => :binds

  validates_presence_of :name
  validates_presence_of :url

  validates_uniqueness_of :name
  validates_uniqueness_of :url

  named_scope :ranked, :order => :karma

  def owners
    binds.all(:conditions => { :kind => :owner}).map(&:user)
  end

  def up_karma!(by=1)
    increment!(:karma, by)
  end

  def self.search(page)
    paginate(:page => page, :per_page => PROJECTS_PER_PAGE, :order => "karma DESC")
  end
end
