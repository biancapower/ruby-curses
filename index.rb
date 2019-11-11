require 'curses'

# initialises curses
Curses.init_screen
begin
  # the number of lines and columns available on the stdscr
  nb_lines = Curses.lines
  nb_cols = Curses.cols
ensure
  Curses.close_screen
end

puts "Number of rows: #{nb_lines}"
puts "Number of columns: #{nb_cols}"
