#    If you pass a block, the session will be passed into the block,
#    and the session will be logged out after the block is executed.
# gmail = Gmail.new(username, password)
# gmail.logout
require 'gmail'
require 'pry-rails'
require "dotenv" ; Dotenv.load

Gmail.new(ENV["GMAIL_USERNAME"], ENV['GMAIL_PASSWORD']) do |gmail|

 emailCount = gmail.inbox.count
 emails = gmail.inbox.emails
 #message includes from, to and subject
 firstEmailMessage = gmail.inbox.emails.first.message
 #body includes message
 firstEmailBody = gmail.inbox.emails.first.body

end