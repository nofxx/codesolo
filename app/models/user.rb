#
# Code Solo 2009
#
class User < ActiveRecord::Base
  has_many :binds, :dependent => :destroy
  has_many :projects, :through => :binds
  has_many :contacts, :as => :contactable, :dependent => :destroy
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :pubs, :dependent => :destroy
  has_many :todos, :dependent => :nullify
  # has_many :friendships
  # has_many :friends, :through => :friendships #, :class_name => "User"

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "50x50>", :tiny => "32x32#" },
                    :whiny_thumbnails => true,
                    :default_style => :thumb,
                    :default_url => "layout/avatar.png",
                    :path => ":rails_root/public/files/users/avatars/:style_:id.:extension",
                    :url => "/files/users/avatars/:style_:id.:extension"


  accepts_nested_attributes_for :contacts,  :allow_destroy => true
  #accepts_nested_attributes_for :addresses, :allow_destroy => true


  acts_as_authentic do |c|
    c.crypto_provider Authlogic::CryptoProviders::BCrypt
    c.logged_in_timeout 30.minutes
    c.validates_length_of_login_field_options :within => 3..30
    # c.validates_format_of_login_field_options :with => /A\w[w\.\-_@ ]+z/, :message => I18n.t('authlogic.validates.format_login_field')
    c.validates_uniqueness_of_login_field_options :allow_blank => false

    c.openid_required_fields = [:nickname, :email]
  end


  def owns?(project)
    project.owners.include? self
  end

  def before_validation
    self.login ||= openid_identifier.split("/")[-1] rescue nil
    self.time_zone ||= "Brasilia"
    self.locale ||= I18n.default_locale
  end

  #after_post_process :iconize
  def after_save
   # Iconis.work(self) if changes.include?("avatar_updated_at")
  end

  def active?
    true #state == :active
  end

  def activate!
    self.update_attribute(:state, :active)
  end

  def get_all_projects
    # curl -i http://github.com/api/v1/json/#{login}
  end


  def update_location(params)
    # point =  Point.from_x_y_z(params[:x], params[:y], params[:z])
    # if Place.close_to(point)
    #   update_attributes(:geom => point)
    # end
  end

  def self.find_by_openid_identifier(identifier)
    u = User.first(:conditions => { :openid_identifier => identifier })
    u ||= User.create(:openid_identifier => identifier)
  end

  private

  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.login = registration["nickname"] if login.blank?
  end



end






# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  login               :string(80)      not null, indexed
#  email               :string(100)     indexed
#  name                :string(100)     default(""), indexed
#  state               :string(255)     default("passive"), not null
#  motto               :string(255)
#  url                 :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)     indexed
#  single_access_token :string(255)     indexed
#  perishable_token    :string(255)     indexed
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  time_zone           :string(50)      not null
#  locale              :string(50)      not null
#  last_login_at       :datetime
#  last_request_at     :datetime        indexed
#  current_login_at    :datetime
#  login_count         :integer
#  skill               :integer         indexed
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  admin               :boolean         default(FALSE), not null, indexed
#  openid_identifier   :string(255)     indexed
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_users_on_openid_identifier    (openid_identifier)
#  index_users_on_last_request_at      (last_request_at)
#  index_users_on_single_access_token  (single_access_token)
#  index_users_on_perishable_token     (perishable_token)
#  index_users_on_persistence_token    (persistence_token)
#  index_users_on_skill                (skill)
#  index_users_on_email                (email)
#  index_users_on_login                (login) UNIQUE
#  index_users_on_admin                (admin)
#  index_users_on_name                 (name)
#

