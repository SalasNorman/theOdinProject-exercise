def knight_moves(start, target)
  moves = [
    [2,1],[1,2],[-1,2],[-2,1],
    [-2,-1],[-1,-2],[1,-2],[2,-1]
  ]

  queue = [[start, [start]]]
  visited = Array.new(8) { Array.new(8, false) }

  visited[start[0]][start[1]] = true

  until queue.empty?
    position, path = queue.shift

    if position == target
      puts "You made it in #{path.length - 1} moves! Here's your path:"
      path.each { |p| p p }
      return path
    end

    moves.each do |dx, dy|
      x = position[0] + dx
      y = position[1] + dy

      next unless x.between?(0,7) && y.between?(0,7)
      next if visited[x][y]

      visited[x][y] = true
      queue << [[x,y], path + [[x,y]]]
    end
  end
end

knight_moves([0,0], [3,3])