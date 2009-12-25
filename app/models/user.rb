#
# Code Solo 2009
#
class User < ActiveRecord::Base
  has_many :binds
  has_many :projects, :through => :binds
  has_many :contacts, :as => :contactable
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
  has_many :pubs
  # has_many :friendships
  # has_many :friends, :through => :friendships #, :class_name => "User"

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "50x50>", :tiny => "32x32#" },
                    :whiny_thumbnails => true,
                    :default_style => :thumb,
                    :default_url => "avatar/default.png",
                    :path => ":rails_root/public/files/users/avatars/:style_:id.:extension",
                    :url => "/files/users/avatars/:style_:id.:extension"


  accepts_nested_attributes_for :contacts,  :allow_destroy => true
  #accepts_nested_attributes_for :addresses, :allow_destroy => true


  symbolize :kind, :in => [:admin, :technic, :owner, :user]


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
    self.kind ||= :user
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


  def update_location(params)
    # point =  Point.from_x_y_z(params[:x], params[:y], params[:z])
    # if Place.close_to(point)
    #   update_attributes(:geom => point)
    # end
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
#  login               :string(80)      not null
#  kind                :string(10)      not null
#  email               :string(100)
#  name                :string(100)     default("")
#  state               :string(255)     default("passive"), not null
#  twitter_pass        :string(50)
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)
#  single_access_token :string(255)
#  perishable_token    :string(255)
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  time_zone           :string(50)      not null
#  locale              :string(50)      not null
#  last_login_at       :timestamp
#  last_request_at     :timestamp
#  current_login_at    :timestamp
#  login_count         :integer
#  doc                 :string(20)
#  reg                 :string(20)
#  on                  :boolean         default(FALSE), not null
#  created_at          :timestamp
#  updated_at          :timestamp
#

