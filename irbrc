exit if RUBY_ENGINE == 'macruby'

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
    
    def include_view_helpers!
      include ActionView::Helpers::DebugHelper
      include ActionView::Helpers::NumberHelper
      include ActionView::Helpers::RawOutputHelper
      include ActionView::Helpers::SanitizeHelper
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::TranslationHelper
      nil
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