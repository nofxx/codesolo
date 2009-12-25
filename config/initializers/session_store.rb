# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_codesolo_session',
  :secret      => '758ab3626c5071b15b9844d1c4fcf9a5869bfe0cce7b5679b6f4017c764d4e2846e1cb0b19102f4d7e765fb62d1fd36d349a7e8d05aa7a1ed12d4b9e173e8638'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
