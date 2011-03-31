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

alias reload! rl unless defined?(Rails)
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
    
    def log_here!
      ActiveRecord::Base.logger = Logger.new STDOUT
      ActiveRecord::Base.clear_reloadable_connections!
      ActionController::Base.logger = Logger.new STDOUT
      nil
    end
  end
end

include Rails::IRBHelpers if defined?(Rails)