class Project < ActiveRecord::Base

  PROJECTS_PER_PAGE = 20
  GH_URL = "http://github.com/api/v2/yaml/repos/show"

  has_many :binds
  has_many :users, :through => :binds

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

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

  def self.search(page)
    paginate(:page => page, :per_page => PROJECTS_PER_PAGE, :order => "karma DESC")
  end

  def split_url
    url.split("/")
  end

  def gh_id
    "#{split_url[-2]}/#{split_url[-1]}"
  end

  def is_set?(v)
    v && v != ''
  end

  def fetch_github
    #begin
     p data = YAML.load(`curl #{GH_URL}/#{gh_id}`)["repository"]
      self.name ||= data[:name]
      self.info = data[:description] unless is_set?(self.info)
      #self.fork ||= data[:fork]
      self.attributes =  {:todos => data[:open_issues],
                          :forks  => data[:forks],
                          :watchers => data[:watchers]}
    p self.attributes
    #rescue => e
    #  puts "GH fetch fail #{e}" + e.backtrace.join("\n")
    #end
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
