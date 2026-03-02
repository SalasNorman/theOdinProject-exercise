def fibs(n)
  # Binet’s formula
  phi = 1.618**n
  psi = (-0.618)**n
  f = (phi - psi) / Math.sqrt(5)
  f.round(0)
end

def fibs_rec(n)

  if n <= 1
    n
  else
    fibs_rec(n-1) + fibs_rec(n-2)
  end
end

array_length = 8

binet_fibs_sequence = (0...array_length).map { |i| fibs(i) }
rec_fibs_sequence = (0...array_length).map { |i| fibs_rec(i) }

puts "Binet's Fibonacci Sequence of #{array_length}: #{binet_fibs_sequence}" 
puts "Recursive Fibonacci Sequence of #{array_length}: #{rec_fibs_sequence}" 


