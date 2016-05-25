puts 3
3.times {
    puts "Hello, world... ;-)"
}

a = 5

if a == 3
    puts "a is 3"
elsif a == 5
    puts "a is 5"
else
    puts "a is not 5 or 3"
end

a = 5

unless a == 6
    puts "a is not 6"
end

a = 10

while a > 9
    puts a
    a -= 1
end

a = 9

until a >= 10
    puts a
    a += 1
end

a = 5
b = 0
puts "One liner" if a == 5 and b == 0

times_2 = 2
times_2 *= 2 while times_2 < 100
puts times_2

puts "0 is true" if 0
puts "false is true?" if "false"
puts "no way - false is false" if false
puts "empty string is true" if ""
puts "nil is true?" if "nil"
puts "no way - nil is false" if nil

if /sera/ === "coursera"
    puts "Triple Equals"
end

if "coursera" === "coursera"
    puts "also works"
end

if Integer === 21
    puts "21 is an Integer"
end

age = 21

case
when age >= 21
    puts "You can buy a drink"
when 1 == 0
    puts "Written by a drunk programmer"
else
    puts "Default condition"
end

name = "Fisher"

case name
when /fish/i then puts "Something is fishy here"
when "Smith" then puts "Your name is Smith"
end

for i in 0..2
    puts i
end

for i in 0...2
    puts i
end

