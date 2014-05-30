#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new
conn.start

ch = conn.create_channel
q  = ch.queue("task_queue", durable: true)

# QUESTION: does this have to come after queue is declared, or is it a channel-specific parameter?
ch.prefetch(1)
puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
q.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
  puts " [x] Received '#{body}'"
  print "     "
  body.count('.').to_i.times {print '.'; sleep 1}
  puts ''
  puts " [x] processed '#{body}'"

  ch.ack(delivery_info.delivery_tag)
end

