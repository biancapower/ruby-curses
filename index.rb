require 'curses'
include Curses

# initialises curses
init_screen

# allows colours
start_color

begin
  # the number of lines and columns available on the stdscr
  nb_lines = lines
  nb_cols = cols

  x = cols / 2  # We will center our text
  y = lines / 2
  setpos(y, x)  # Move the cursor to the center of the screen
  init_pair(1, Curses::COLOR_RED, Curses::COLOR_GREEN)
  attrset(color_pair(1) | Curses::A_BOLD)
  addstr("Hello World")
  refresh
  getch

ensure
  close_screen
end

puts "Number of rows: #{nb_lines}"
puts "Number of columns: #{nb_cols}"
