exit if RUBY_ENGINE == 'macruby'

require 'rubygems'

require 'irb/completion'
require 'irb/ext/save-history'

begin
  require 'awesome_print'
rescue LoadError
  # don't care
end

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
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  def ivg name
    instance_variable_get name
  end

  def ivs name, value
    instance_variable_set name, value
  end
end

def desktop(filename = 'irb-session.txt', &block)
  File.open("/Users/rob/Desktop/#{filename}", 'w+') do |f|
    f << block.call
  end
end

# Hirb

def hirb!
  require 'hirb'
  Hirb.enable
end

def unhirb!
  Hirb.disable if defined?(::Hirb)
end

def benchmark
  bm = Benchmark.realtime{ yield }
  puts "%0.2f Second(s)" % bm
end

def pbcopy(what)
  IO.popen('pbcopy', 'w'){ |f| f << what.to_s }
end

def pbpaste
  `pbpaste`.chomp
end

def cls
  system 'clear'
  nil
end

# reload a single file
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

def load(file)
  IRB.conf[:LOAD_MODULES] |= Array(file)
  super
end

# reload all included files
def reload!
  IRB.conf[:LOAD_MODULES].each do |file|
    puts "Reload: #{file}"
    load file
  end
end unless defined?(Rails)

alias x exit

# Rails Specific Helpers

module Rails
  module IRBHelpers
    def sql(query)
      ActiveRecord::Base.connection.select_all(query)
    end

    def change_log(stream)
      ActiveRecord::Base.logger = Logger.new(stream)
      ActiveRecord::Base.clear_active_connections!
    end

    def show_log
      change_log(STDOUT)
    end

    def hide_log
      change_log(nil)
    end
  end
end

include Rails::IRBHelpers if defined?(Rails)

# Machine specific helpers

localrc = File.expand_path('.localirbrc', File.dirname(__FILE__))
if File.exists?(localrc)
  load localrc if %w{irb script/rails}.include?($0)
end
