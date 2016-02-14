#    If you pass a block, the session will be passed into the block,
#    and the session will be logged out after the block is executed.
# gmail = Gmail.new(username, password)
# gmail.logout
require 'gmail'
require 'pry-rails'
require "dotenv" ; Dotenv.load
require 'pry'
require 'nokogiri'

class Wodify
  def initialize
    Gmail.new(ENV["GMAIL_USERNAME"], ENV['GMAIL_PASSWORD']) do |gmail|

      emails = gmail.inbox.emails
      #message includes from, to and subject
      # message = emails.first.message
      #body includes message
      # body = emails.first.body

      # wodify_emails(emails).each do |email|

      wodify_emails(emails).first.body.to_s.scan( /<([^>]*)>/).each do |section|
        if section.first.include? 'a id=3D"wt4"'
           link = section.first.gsub("=\n", "")
           puts link.sub!(/.*?(?="http)/im, "")
        end
      end

    end
  end

  def wodify_emails(emails)
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