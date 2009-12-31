#
# Code Solo
#
# Create initial data

["admin", "juvenal", "jaodonato", "nofxx",  "joker", "unknown"].each do |user|
  User.create(:login => user, :password => user, :admin => false,
             # :avatar => user == "unknown" ? nil : File.new(RAILS_ROOT + "/db/avatars/#{p}.jpg"),
             :password_confirmation => user, :state => :active, :name => user.capitalize,
             :email => "#{user}@fireho.com", :time_zone => "Brasilia", :locale => "en")
end

# ["Rock", "Bike", "Ruby", "Linux"].each do |g|
#   Group.create(:name => g)
# end

["C", "ruby", "erlang", "java", "javascript", "xmpp", "rails",
 "C++", "sql", "tokyo", "mongodb", "couchdb", "voldemort"].each do |n|
  Tag.create(:name => n)
end

User.find_by_login("joker").update_attribute(:motto, "Why so serious?")

Project.create!(:name => "codesolo", :url => "http://github.com/nofxx/codesolo", :skill => 2)

nofxx = User.find_by_login("nofxx")
nofxx.binds.create(:project => Project.first, :kind => :owner)
nofxx.admin = true
nofxx.save

