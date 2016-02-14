#    If you pass a block, the session will be passed into the block,
#    and the session will be logged out after the block is executed.
# gmail = Gmail.new(username, password)
# gmail.logout
require 'gmail'
require 'pry-rails'
require "dotenv" ; Dotenv.load
require 'pry'
require 'net/http'

class Wodify
  def initialize
    Gmail.new(ENV["GMAIL_USERNAME"], ENV['GMAIL_PASSWORD']) do |gmail|
      emails = gmail.inbox.emails

      wodify_emails = get_emails(emails)
      link = get_link(wodify_emails)

      Net::HTTP.get(URI(link))
    end
  end


  #right now this calls .first and is only getting the first email
  def get_link(emails)
    link = ""

    emails.first.body.to_s.scan( /<([^>]*)>/).each do |section|
      if section.first.include? 'a id=3D"wt4"'
         #get rid of new lines
         #get rid of the substring before the link starts
         #get rid of extra '/"''s
         link = section.first.gsub("=\n", "").sub!(/.*?(?="http)/im, "").tr('\"', "")
      end
    end

    link
  end

  def get_emails(emails)
    wodify_emails = []

    emails.each do |email|
      if email.subject.include? "class is open for reservation"
        wodify_emails << email
      end
    end

    wodify_emails
  end
end

Wodify.new