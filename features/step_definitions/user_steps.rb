Given /^I am logged in as "([^\"]*)"$/ do |arg1|
  Given "I am logged in as \"#{arg1}\" with password \"#{arg1}\""
end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |username, password|
  @cu = User.find_by_login(username) || User.create(:login => username, :password => username, :password_confirmation => username, :email => "foo@#{username}.com")
  unless username.blank?
    visit '/login'
    fill_in "user_session_login", :with => username
    fill_in "user_session_password", :with => password
    click_button "Login"
  end
end

Given /^I am logged in as an "([^\"]*)"$/ do |role|
  #@cu = User.find_by_nome(role) || User.generate(:login => role, :nome => role)
  if role =~ /admin/
  end
  @cu.save
  unless role.blank?
    visit root_path
    fill_in "user_session_login", :with => role
    fill_in "user_session_password", :with => "password"
    click_button "Entrar"
  end
end

Given /^I have a contact "([^\"]*)"$/ do |contact|
  @cu.contacts.build(:valor => contact, :kind => "email")
  @cu.save
end

When /^I visit profile for "([^\"]*)"$/ do |username|
  user = User.find_by_username!(username)
  visit user_url(user)
end

# features/step_definitions/user_steps.rb
Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Then /^I should see my name$/ do
   response.should contain(@cu.nome)
end

Given /^there is no user$/ do
  User.delete_all
end
