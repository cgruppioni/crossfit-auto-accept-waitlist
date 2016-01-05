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
  message = emails.first.message
  #body includes message
  body = emails.first.body

  wwc_emails = []

  emails.each do |email|
    if email.subject == "New members in Women Who Code Boston"
      wwc_emails << email
    end
  end

  puts wwc_emails
end
