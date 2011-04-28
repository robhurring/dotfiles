#!/usr/bin/env ruby
# from http://errtheblog.com/posts/89-huba-huba

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
