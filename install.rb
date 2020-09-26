#!/usr/bin/env ruby

list_theme = `ls -1d */`.gsub("\/", '').split("\n")

puts 'Select your Key-mon theme!'
list_theme.each_with_index do |theme, index|
  puts " (#{index + 1}) #{theme.capitalize}"
end
puts "\nEnter theme number:"
print '=> '
selected_theme = gets.chomp
selected_theme_name = list_theme[selected_theme.to_i - 1]

Dir.chdir(selected_theme_name)
puts "\nKamu berada di dalam direktori #{selected_theme_name.capitalize}"

unless `ls -p | grep -v /`.empty?
  list_style = `ls -p | grep -v /`.split("\n")
else
  puts "\nTidak ada style di dalam direktori ini"
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

puts "\nKamu memilih style: #{selected_style_name}"

puts "\nApakah kamu siap untuk melakukan instalasi style? [y/n]"
print '=> '
agreement = gets.chomp
if %w[y Y].include? agreement
  puts "\nAyo kita install!"
  puts
  system "sudo cp -vf #{selected_style_name} \
                      #{keymon_dir}/#{selected_theme_name}/meta.svg"
  puts "\nProses instalasi SELESAI!"
elsif %w[n N].include? agreement
  puts "\nAh, Mungkin lain kali"
else
  puts "\nKamu tidak memasukkan jawaban yang benar"
end
# system 'sudo cp -vf'
