require 'rubygems'
require 'blather/client'

setup '1098077652074@gcm.googleapis.com', 'AIzaSyCAPZQ7GDiVXSdLPMeYNhTz6hbO6Q3Rdao','gcm.googleapis.com', 5235, './certs'

when_ready do
  say '1098077652074@gcm.googleapis.com', 'Hi GCM!'
end

# Auto approve subscription requests
subscription :request? do |s|
  write_to_stream s.approve!
end

# Echo back what was said
message :chat?, :body do |m|
  puts "Received message from GCM: from_field:#{m.from}, message_body: #{m.body}"
  say m.from, "You said: #{m.body}"
end