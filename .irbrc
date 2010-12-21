require 'rubygems'

require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf.merge!({
  :USE_READLINE => true,
  :SAVE_HISTORY => 100,
  :HISTORY_FILE => "#{ENV['HOME']}/.irb_history",
  :AUTO_INDENT => true,
  :PROMPT_MODE => :SIMPLE
})

require 'pp'
require 'benchmark'

class Object
  def my_methods
    methods.sort - ancestors[1].methods
  end
  
  def my_instance_methods
    instance_methods.sort - ancestors[1].instance_methods
  end
end

def benchmark
  bm = Benchmark.realtime{ yield }
  puts "%0.2f Second(s)" % bm
end

def pbcopy(what)
  `echo #{what.to_s.chomp}|pbcopy`
  what.to_s
end

def pbpaste
  `pbpaste`.chomp
end

def cls
  system 'clear'
  nil
end

def rl(file = nil)
  if file.nil?
    @__reload__ ? rl(@__reload__) : puts("Nothing to reload.")
  else
    file = file.to_s unless file.is_a?(String)
    file << ".rb" unless file =~ /\.rb$/i
    @__reload__ = file
    puts "Loading: #{@__reload__}"
    load @__reload__
    nil
  end
end

alias x exit