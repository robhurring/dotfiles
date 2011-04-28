#!/usr/bin/env ruby
# from http://errtheblog.com/posts/89-huba-huba

home = ENV['HOME']
ignore = %{bin install.rb .mybashrc}
force = ARGV[0] == '-f'
dotfiles_dir = File.expand_path File.dirname(__FILE__)

Dir.chdir dotfiles_dir do
  (Dir['*']+Dir['bin/*']).each do |file|
    next if ignore.include?(file)
    target_name = file =~ /^bin/ ? file : ".#{file}"
    target = File.join(home, target_name)
    if force || !File.exist?(target)
      system %[ln -vsf #{File.join(dotfiles_dir, file)} #{target}]
    end
  end
end
puts <<-EOF

Make sure to change your git details in ~/.mybashrc
 
  export GIT_COMMITTER_NAME=""
  export GIT_COMMITTER_EMAIL=""

See .mybashrc for example usage.

EOF