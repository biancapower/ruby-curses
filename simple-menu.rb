require 'curses'
#require 'pry'

Curses.init_screen    # Init Curses
WIDTH  = Curses.cols  # Get width of terminal window
HEIGHT = Curses.lines # Get height of terminal window

Curses.curs_set(0) # Makes cursor invisible
Curses.noecho      # Typing characters will not display on screen
Curses.cbreak      # Exit on ^C

OPTIONS = ["Curabitur varius metus at ex semper ultrices.", "Morbi ornare orci elit, id tincidunt elit laoreet et.", "Suspendisse luctus arcu at imperdiet ultricies.", "Donec mollis ultricies faucibus."]

@highlight = 0 # This is a pointer to the currently "selected" item

def display_menu
  current_line = 1 # Init a variable to hold our current line

  OPTIONS.each_with_index do |opt, idx|  # Iterate over collection
    WINDOW.setpos(current_line, 1)       # Set cursor position
    if @highlight == idx                 # Check if highlight and idx match
      WINDOW.attron(Curses::A_STANDOUT)  # Turn highlight on
      WINDOW.addstr(opt)                 # Add string
      WINDOW.attroff(Curses::A_STANDOUT) # Turn highlight off
    else
      WINDOW.addstr(opt)                 # If highlight and idx do not match,
    end                                  # then simply add the string
    current_line += 1                    # Update our current line pointer
  end

end

def move_highlight_down
  # We have to check if the last option is
  # currently selected and if so, then move
  # the highlight back to the top of the list.
  # Otherwise, we increment the highlight pointer
  if @highlight == OPTIONS.length - 1
    @highlight = 0
  else
    @highlight += 1
  end
end

def move_highlight_up
  # Check if the first option is currently
  # selected and if so, then move the highlight
  # to the bottom of the list. Otherwise, we
  # decrement the highlight pointer
  if @highlight == 0
    @highlight = OPTIONS.length - 1
  else
    @highlight -= 1
  end
end

begin
  # Initialize a window to hold our menu
  WINDOW = Curses::Window.new(8, 60, (HEIGHT - 8)/2, (WIDTH - 60)/2)
  # Draw a nice border around it
  WINDOW.box("|", "-")
  # Loop until 'q' is pressed
  # This is the part of the program that lets the user scroll through options!
  # We create a loop, calling `display_menu` at the start. When then get a
  # single character from the user. If that character is one of our defined
  # control characters, we perform an action, only breaking out when 'q' pressed
  loop do
    display_menu
    Curses.refresh
    # `getch` gets a single character from the user
    ch = WINDOW.getch
    case ch
    when 'j' # Move down with the 'j' key
      move_highlight_down
    when 'k' # Move up with the 'k' key
      move_highlight_up
    when 'q' # Quit
      break
    end
  end
ensure
  Curses.close_screen # End Curses
end
