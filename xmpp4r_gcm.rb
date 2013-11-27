#!/usr/bin/ruby

# This bot will reply to every message it receives. To end the game, send 'exit'

require 'rubygems'
require 'xmpp4r/client'
include Jabber


# settings
=begin
if ARGV.length != 2
  puts "Run with ./echo_thread.rb user@server/resource password"
  exit 1
end
=end
myJID = JID.new('1098077652074@gcm.googleapis.com')
myPassword = 'AIzaSyCAPZQ7GDiVXSdLPMeYNhTz6hbO6Q3Rdao'
cl = Client.new(myJID)
cl.connect('gcm.googleapis.com', 5235)
cl.auth(myPassword)
cl.send(Presence.new)
puts "Connected ! send messages to #{myJID.strip.to_s}."
mainthread = Thread.current
cl.add_message_callback do |m|
  if m.type != :error
    m2 = Message.new(m.from, "You sent: #{m.body}")
    m2.type = m.type
    cl.send(m2)
    if m.body == 'exit'
      m2 = Message.new(m.from, "Exiting ...")
      m2.type = m.type
      cl.send(m2)
      mainthread.wakeup
    end
  end
end
Thread.stop
cl.close

