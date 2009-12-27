class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true

  symbolize :kind, :in => [:mail, :tel, :cel, :nextel, :skype,
                          :msn, :sms, :fax, :other], :i18n => false

  validates_presence_of :value
  validates_length_of :value, :in => (3..50), :allow_blank => true
  validates_length_of :info, :maximum => 255, :allow_nil => true

  validates_format_of :value, :with => /(.+)@(.+)\.(.{2})/,
    :if => lambda { |s| s.kind == :email }

  named_scope :mail, :conditions => {:contato_type => :mail }

end




# == Schema Information
#
# Table name: contacts
#
#  id               :integer         not null, primary key
#  contactable_id   :integer(20)     indexed => [contactable_type]
#  contactable_type :string(20)      indexed => [contactable_id]
#  kind             :string(5)       not null, indexed
#  value            :string(50)      not null
#  info             :text
#
# Indexes
#
#  index_contacts_on_contactable_type_and_contactable_id  (contactable_type,contactable_id)
#  index_contacts_on_kind                                 (kind)
#

