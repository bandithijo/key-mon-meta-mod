#!/usr/bin/env ruby

list_theme = `ls -1d */`.gsub("\/", '').split("\n")

['sample'].each do |exclude|
  list_theme.delete(exclude)
end

puts 'Select your Key-mon theme!'
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

keymon_dir = '/usr/lib/python3.8/site-packages/keymon/themes'

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
