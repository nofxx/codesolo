#
# Code Solo
#
# Create initial data


["admin", "juvenal", "jaodonato", "boxmo", "cachorra", "clecle", "nofxx", "marcos", "joker", "unknown"].each do |p|
  User.create(:login => p, :password => p, :kind => :admin, :on => true,
             # :avatar => p == "unknown" ? nil : File.new(RAILS_ROOT + "/db/avatars/#{p}.jpg"),
             :password_confirmation => p, :state => :active, :name => p.capitalize,
             :email => "#{p}@fireho.com", :time_zone => "Brasilia", :locale => "pt")
end

# ["Rock", "Bike", "Ruby", "Linux"].each do |g|
#   Group.create(:name => g)
# end


User.find_by_login("joker").update_attribute(:motto, "Why so serious?")

Project.create(:name => "jah", :url => "http://github.com/nofxx/jah")

nofxx = User.find_by_login("nofxx")
nofxx.binds.create(:project => Project.first, :kind => :owner)
#nofxx.save
