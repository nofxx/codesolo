class Project < ActiveRecord::Base

  PROJECTS_PER_PAGE = 20
  # Using search because repo info doesn't have all the info =/
  GH_URL = "http://github.com/api/v2/yaml/repos/search"

  has_many :binds, :dependent => :destroy
  has_many :users, :through => :binds

  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings

  has_many :pubs, :dependent => :destroy
  has_many :todos, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :url

  validates_uniqueness_of :name
  validates_uniqueness_of :url

  validates_numericality_of :watchers, :forks, :todos_count
  validates_inclusion_of :skill, :in => 1..5
  validates_inclusion_of :devs, :in => 1..50

  named_scope :ranked, :order => :karma
  named_scope :last_ones, :order => "created_at DESC", :limit => 7

  def to_param
    name
  end

  def owners
    binds.all(:conditions => { :kind => :owner}).map(&:user)
  end

  def up_karma!(by=1)
    increment!(:karma, by)
  end

  def tags_text
    tags.map(&:name).join(" ")
  end

  def tags_text=(text)
    text.chomp.split(/\s|\,\s*/).each do |tag|
      t = Tag.find_or_create_by_name(tag)
      self.tags << t unless self.tags.include?(t)
    end
  end

  def self.search(page, search = nil)
    args = {:page => page, :per_page => PROJECTS_PER_PAGE, :order => "projects.karma DESC"}
    args.merge!(:conditions => ['projects.info like ?', "%#{search}%"]) if search
    paginate(args)
  end

  def gh_id
    repo, user = url.split("/").reverse
    { :name => repo, :user => user}
  end

  def is_set?(v)
    v && v != ''
  end

  def fetch_github
    begin
      repo = Octopi::Repository.find(gh_id)
      self.name ||= repo.name
      self.info = repo.description unless is_set?(info)
      self.todos << repo.issues.map do |i|
        next if i.state == "closed"
        Todo.new(:name => i.title, :priority => i.votes)
      end
      self.attributes =  {:todos_count => repo.open_issues,
                          :forks  => repo.forks,
                          :watchers => repo.watchers}
      tags_text = (repo.tags << repo.language).join(" ")
      # repo.pledgie
      self.synced_at = repo.pushed
    rescue => e
      puts "GH fetch fail #{e}" + e.backtrace.join("\n")
    end
  end

  def before_validation
    self.issues = url + '/issues' if url && !is_set?(issues)
    self.devs = 1 if devs.zero?
   # fetch_github unless self.name
  end

  def before_save
    fetch_github
  end
end

# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null, indexed
#  url         :string(255)     indexed
#  issues      :string(255)
#  wiki        :string(255)
#  forum       :string(255)
#  mailist     :string(255)
#  irc         :string(255)
#  devs        :integer         default(0), not null, indexed
#  karma       :integer         default(0), not null, indexed
#  skill       :integer         default(0), not null, indexed
#  todos_count :integer         default(0), not null, indexed
#  forks       :integer         default(0), not null, indexed
#  watchers    :integer         default(0), not null, indexed
#  fork        :boolean         default(FALSE), not null
#  tests       :boolean         default(FALSE), not null
#  private     :boolean         default(FALSE), not null, indexed
#  info        :text
#  synced_at   :datetime        indexed
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_projects_on_synced_at    (synced_at)
#  index_projects_on_forks        (forks)
#  index_projects_on_watchers     (watchers)
#  index_projects_on_todos_count  (todos_count)
#  index_projects_on_url          (url)
#  index_projects_on_skill        (skill)
#  index_projects_on_karma        (karma)
#  index_projects_on_private      (private)
#  index_projects_on_devs         (devs)
#  index_projects_on_name         (name)
#

