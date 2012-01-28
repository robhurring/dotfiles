require 'rake'
require 'erb'

# credit to Ryan Bates for this install script
# https://github.com/ryanb/dotfiles
desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  (Dir['*']+Dir['bin/*']).each do |file|
    next if %w[Rakefile bin install.rb mybashrc.example localrc.example Gemfile Gemfile.lock].include? file

    prefix = file =~ /^bin/ ? '' : '.'
    file_s = "#{prefix}#{file.sub('.erb', '')}"

    if File.exist?(File.join(ENV['HOME'], "#{file_s}"))
      if File.identical? file, File.join(ENV['HOME'], file_s)
        puts "identical ~/#{file_s}"
      elsif replace_all
        replace_file(file, prefix)
      else
        print "overwrite ~/#{file_s}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file, prefix)
        when 'y'
          replace_file(file, prefix)
        when 'q'
          exit
        else
          puts "skipping ~/#{file_s}"
        end
      end
    else
      link_file(file, prefix)
    end
  end
end

def replace_file(file, prefix='.')
  system %Q{rm -rf "$HOME/#{prefix}#{file.sub('.erb', '')}"}
  link_file(file, prefix)
end

def link_file(file, prefix='.')
  target = "#{prefix}#{file.sub('.erb', '')}"
  if file =~ /.erb$/
    puts "generating ~/#{target}"
    File.open(File.join(ENV['HOME'], "#{target}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/#{target}"
    system %Q{ln -snf "$PWD/#{file}" "$HOME/#{target}"}
  end
end