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


msgs_handled = 0
begin
  q.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
    puts " [x] Received '#{body}'"
    print "     "
    body.count('.').to_i.times {print '.'; sleep 1}
    puts ''
    puts " [x] Done"
    msgs_handled += 1

    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  $stderr.puts("========> Handled #{msgs_handled} messages <========")
  conn.close
end

