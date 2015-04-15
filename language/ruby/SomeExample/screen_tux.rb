#!/usr/bin/ruby 

require 'io/console'

character = <<ENDD
        .--.
       |o_o |
       |:_/ |
      //   \\ \\
     (|     | )
    /'\\_   _/`\\
    \\___)=(___/
ENDD
column = 0
row = 0;


def print_character(row, column, character)
  row.times {puts}
  column.times {print " "}
  puts
  character.split("\n").each { |item|
    column.times {print " "}
    print item
    puts
  }
end 

while true do 
  system "clear"
  ran_col = 60
  c = Random.new
  column = c.rand(ran_col) + 1

  ran_row = 40
  r = Random.new
  row = r.rand(ran_row) + 1

  print_character(row, column, character)
  sleep(1)
end


#while true do
#  ch = STDIN.getch
#  case 
#  when "h" == ch.to_str
#    system "clear"
#    column -= 1
#    print_character(row, column, character)
#when "l" == ch.to_str
#    system "clear"
#    column += 1
#    print_character(row, column, character)
#  when "j" == ch 
#    system "clear"
#    row += 1
#    print_character(row, column, character)
#  when "k" == ch 
#    system "clear"
#    row -= 1
#    print_character(row, column, character)
#  when "q" == ch.to_str
#    system "clear"
#    break
#  end
#end 
#
