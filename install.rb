#!/usr/bin/env ruby

# This is a Ruby wraper script for change the Meta/Super key logo of your
# Key-mon. You can choose your Meta modification style with this installation
# script install.rb.
# source  : https://github.com/bandithijo/key-mon-meta-mod
# author  : bandithijo@gmail.com
# created : 2020/09/27

puts "\nThis installation script will ask
your administrator password with sudo."
puts "\nAre you agree with that? [y/n]"
print '=> '
continue = gets.chomp
if %w[y Y].include? continue
  return
elsif %w[n N].include? continue
  puts "Ok. It's fine"
  exit
else
  puts 'You enter wrong answer'
  exit
end

# Please take a look a installation path of your keymon.
# It probably difference with my own system.
python_lib_path = `sudo python -c "import sys; print(sys.path[4])"`
keymon_dir = python_lib_path.strip << '/keymon/themes'

puts "\nYour Key-Mon installation directory is on:
#{keymon_dir.sub('/themes', '')}"

list_theme = `ls -1d */`.gsub("\/", '').split("\n")

['sample'].each do |exclude|
  list_theme.delete(exclude)
end

puts "\nSelect your Key-mon theme!"
list_theme.each_with_index do |theme, index|
  puts " (#{index + 1}) #{theme.capitalize}"
end
puts "\nEnter theme number:"
print '=> '
selected_theme = gets.chomp
selected_theme_name = list_theme[selected_theme.to_i - 1]

Dir.chdir(selected_theme_name)
puts "\nYou are in #{selected_theme_name.capitalize} directory"

unless `ls -p | grep -v /`.empty?
  list_style = `ls -p | grep -v /`.split("\n")
else
  puts "\nThere are no style in this directory"
  exit
end

puts "\nSelect you modification style:"
list_style.each_with_index do |style, index|
  puts " (#{index + 1}) #{style}"
end

puts "\nEnter style number"
print '=> '
selected_style = gets.chomp
selected_style_name = list_style[selected_style.to_i - 1]

puts "\nYou choose: #{selected_style_name}"

puts "\nAre you sure want to change the style? [y/n]"
print '=> '
agreement = gets.chomp
if %w[y Y].include? agreement
  puts "\nLet's party!"
  puts
  system "sudo cp -vf #{selected_style_name} \
                      #{keymon_dir}/#{selected_theme_name}/meta.svg"
  puts "\nInstallation COMPLETED!"
elsif %w[n N].include? agreement
  puts "\nAh, Maybe later"
else
  puts "\nYou are not enter the correct answer"
end
