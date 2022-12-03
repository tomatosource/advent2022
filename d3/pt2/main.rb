require "set"

lines = File.read("input.txt").split
  .map {|line| line.split("")}

x = 0
sum = 0
while x < lines.length
  letter = lines[x+0].to_set
    .intersection(lines[x+1].to_set)
    .intersection(lines[x+2].to_set)
    .to_a[0]

  letter < 'a' ?
    sum += letter.ord - 38 :
    sum += letter.ord - 96

  x += 3
end

puts sum
