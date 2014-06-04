#!/usr/bin/env ruby
# encoding: utf-8
# code based on http://www.rabbitmq.com/tutorials/tutorial-four-ruby.html

require "bunny"

if ARGV.empty?
  abort "Usage: #{$0} [binding key]"
end

conn = Bunny.new
conn.start

ch  = conn.create_channel
x   = ch.topic("topic_logs")
q   = ch.queue("", :exclusive => true)

ARGV.each do |severity|
  q.bind(x, :routing_key => severity)
  puts "     binding q to x with key: #{severity}"
end

puts " [*] Waiting for logs. To exit press CTRL+C"

msgs_handled = 0
begin
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] #{delivery_info.routing_key}:#{body}"
    msgs_handled += 1
  end
rescue Interrupt => _
  $stderr.puts("========> Handled #{msgs_handled} messages <========")
  ch.close
  conn.close
end

