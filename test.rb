answer = Array.new
local_var = 'testvar'
@instance_var = 'testvar2'

### scoping
# puts 'Do you like Ruby?'

# for number in 0..2
#    answer << gets.chomp
# end

# puts "Answer: #{answer[0].to_s}"
# puts "Answer array: #{answer.join}"

# def method 
#   puts "Method: #{@instance_var}"
# end

# puts "Local: #{local_var}"
# method

### If statement
# puts 'first number to compare: '
# x = gets.chomp.to_i 
# puts 'second number to compare: '
# y = gets.chomp.to_i

# greater_than = x <=> y

# if greater_than == 1
#   puts "#{x} is greater than #{y}"
# elsif greater_than ==-1 && greater_than != 0    
#   print "#{x} is smaller than #{y}"
#   puts x > 10 ? ', but bigger than 10' : ''
# else
#   puts 'I can\'t guess the number'
# end

### Break
# for i in 0..5
#     if i > 2
#         puts "Value of local variable is greater than 2"
#         next
#     end
#     puts "Value of local variable is #{i}"
#   end

### Blocks
def test
    puts 'You are in the method'
    yield
    puts 'You are back to the method again'
    yield
    puts 'You are back to the method once more'
    yield
  end
  
  test { puts 'You have yielded the method' }

### Blocks with arguments
def test
    yield 5, 7
    puts 'You are in the method test'
    yield 100, 84
 end
 
 test { |i, j| puts "You are in block #{i}, giving #{j}" }