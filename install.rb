#!/usr/bin/env ruby
# Usage: install.rb [-f]
#   -f  force symlinking
#       [Defailt: symlink if the file doesn't exist]

$force = ARGV[0] == '-f'
$home = ENV['HOME']
$here = File.expand_path File.dirname(__FILE__)
$ignore = %w{.mybashrc.example .git}

# link dotfiles
Dir.chdir $here do
  (Dir['.*'] + Dir['bin/*']).each do |file|
    next if file =~ /^\.{1,2}$/ || $ignore.include?(file)
    from = File.join($here, file)
    to = File.join($home, file)

    if $force || !File.exist?(to)
      system %{ln -vsfh #{from} #{to}}
    end
  end
end

puts <<-EOF

See .mybashrc for machine-specific example usage

EOF
