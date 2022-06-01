require './game'

# Make a glider
alive_cells = [
  [1, 3],
  [2, 1],
  [2, 3],
  [3, 2],
  [3, 3]
]

g = Game.new(alive_cells: alive_cells)

puts 'first draw'
g.draw

30.times do |i|
  system 'cls'
  puts "Tick: #{i}"
  g.tick
  g.update
  g.draw
  sleep(0.1)
end
