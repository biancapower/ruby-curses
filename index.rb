require 'curses'
include Curses

# initialises curses
init_screen
begin
  # the number of lines and columns available on the stdscr
  nb_lines = lines
  nb_cols = cols
ensure
  close_screen
end

puts "Number of rows: #{nb_lines}"
puts "Number of columns: #{nb_cols}"
