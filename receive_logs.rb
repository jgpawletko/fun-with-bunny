#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new
conn.start

ch = conn.create_channel
x  = ch.fanout("logs")
q  = ch.queue("", exclusive: true)

q.bind(x)

puts " [*] Waiting for logs. To exit press CTRL+C"


msgs_handled = 0
begin
  q.subscribe(block: true) do |delivery_info, properties, body|
    puts " [x] Received '#{body}'"
    msgs_handled += 1
  end
rescue Interrupt => _
  $stderr.puts("========> Handled #{msgs_handled} messages <========")
  ch.close
  conn.close
end

