def merge_sort(arr)
  return arr if arr.length <= 1
  
  mid = arr.length / 2
  left = merge_sort(arr[0...mid]) #3 dot exclude mid
  right = merge_sort(arr[mid..])
  merge(left, right)
end

def merge(left, right)
  result = []
  i = j = 0
  while i < left.length && j < right.length
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

    result += left[i..] if i < left.length
    result += right[j..] if j < right.length
    
    result
end

numbers = [8,3,5,4,2,9]
sorted = merge_sort(numbers)
puts "Given Array: #{numbers}"
puts "Merge Sort: #{sorted}"