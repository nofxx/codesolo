class Project < ActiveRecord::Base

  PROJECTS_PER_PAGE = 20
  # Using search because repo info doesn't have all the info =/
  GH_URL = "http://github.com/api/v2/yaml/repos/search"

  has_many :binds
  has_many :users, :through => :binds

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  has_many :pubs

  validates_presence_of :name
  validates_presence_of :url

  validates_uniqueness_of :name
  validates_uniqueness_of :url

  validates_numericality_of :watchers, :forks, :todos
  validates_inclusion_of :skill, :in => 1..5
  validates_inclusion_of :devs, :in => 1..50

  named_scope :ranked, :order => :karma

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
     p repo = Octopi::Repository.find(gh_id)
      self.name ||= repo.name
      self.info = repo.description unless is_set?(info)
      self.attributes =  {:todos => repo.open_issues,
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
    self.todo = url + '/issues' if url && !is_set?(todo)
    self.devs = 1 if devs.zero?
   # fetch_github unless self.name
  end

  def before_save
    fetch_github
  end
end
