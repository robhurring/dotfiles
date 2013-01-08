require 'rake'
require 'erb'

desc 'link shared dotfiles to ~'
task :etc do
  link_tree Dir['etc/*'], '~', '.'
end

desc 'link shared binfiles to ~/bin'
task :bin do
  link_tree Dir['bin/*'], '~/bin', ''
end

task :env => [:etc, :bin]

desc 'install the ZSH dotfiles to home'
task :zsh => :env do
  safe_replace_file '~/.zsh', 'shells/zsh'
  puts "\ncopy #{File.expand_path './example/zshrc'} to ~/.zshrc to setup ZSH\n"
end

desc 'install the BASH dotfiles to home'
task :bash => :env do
  safe_replace_file '~/.bash', 'shells/bash'
  puts "\ncopy #{File.expand_path './example/bashrc'} to ~/.bashrc to setup ZSH\n"
end

desc 'link up vim dotfiles to home'
task :vim do
  safe_replace_file '~/.vimrc', 'etc/vimrc'
  safe_replace_file '~/.vim', 'shells/vim'
end

desc 'link up oh-my-zsh custom files'
task :omz do
  safe_replace_file '~/.omz-custom', 'shells/omz-custom'
  puts "\nset ZSH_CUSTOM=~/.omz-custom in your ~/.zshrc file"
end

# Helpers
$replace_all = false

def link_tree(from, destination = ENV['HOME'], prefix = '.')
  replace_all = false
  destination = File.expand_path(destination)

  Array(from).each do |source|
    filename = "#{prefix}#{File.basename(source).sub(/.erb$/, '')}"
    target = File.join(destination, "#{filename}")

    safe_replace_file target, source
  end
end

def safe_replace_file(target, source)
  target = File.expand_path(target)
  source = File.expand_path(source)

  if File.exists?(target)
    if File.identical?(source, target)
      puts "identical: #{target}"
    elsif $replace_all
      replace_file(target, source)
    else
      print "overwrite: #{target} [ynaq] -> "
      case $stdin.gets.chomp
      when 'a'
        $replace_all = true
        replace_file(target, source)
      when 'y'
        replace_file(target, source)
      when 'q'
        exit 1
      else
        puts "skipping: #{source}"
      end
    end
  else
    link_file source, target
  end
end

def replace_file(target, source, link = true)
  system %Q{rm -rf #{target}}
  if link
    link_file(source, target)
  else
    puts "copying: #{source} -> #{target}"
    %x{cp -f #{source} #{target}}
  end
end

def link_file(source, target)
  target = File.expand_path(target)
  source = File.expand_path(source)

  if File.extname(source) == '.erb'
    target = target.sub /\.erb$/, ''
    puts "generating: #{source} -> #{target}"

    data = ERB.new(File.read(source)).result(binding)
    File.open(File.join(target), 'w') do |new_file|
      new_file.write data
    end
  else
    puts "linking: #{source} -> #{target}"
    %x{ln -snf #{source} #{target}}
  end
end
