def number_check (string)
    Float(string) rescue false
end

def addition(a, b)
    a+b
end
    
def substraction(a, b)
    a-b
end
  
def division(a, b)
    a/b
end
 
def multiplication(a, b)
    a*b
end
    
def exponent(a, b)
    a**b
end    

def modulo(a, b)
    a%b
end

def switch_calculation_case (operators, values)

    counter = 0
    result = 'something went wrong'

    operators.each do |operator|
        value1 = result == 'something went wrong' ? values[counter] : result
        value2 = values[counter + 1]
        
        case operator
        when 'plus', '+'
            result = addition(value1, value2)
        when 'minus', '-'
            result = substraction(value1, value2)
        when 'dividedby', '/'
            result = division(value1.to_f, value2)
        when 'times', '*', 'x'
            result = multiplication(value1, value2)
        when 'powerto', '**', '^'
            result = exponent(value1, value2)
        when 'mod', 'modulo', '%'
            result = modulo(value1, value2)
        else 
            result = 'can\'t parse'
        end

        puts result
        counter += 1
    end

    get_formula
end

def get_formula
    calculation = Array.new
    values = Array.new
    operators = Array.new
    
    puts 'what do you want to calculate?'

    calculation = gets.chomp.split
    
    return if calculation[0] == 'exit'

    previous_was_string = false

    calculation.each do |split|
        if number_check(split)
            if  (split.to_f == split.to_i)
                values << split.to_i    
            else 
                values << split.to_f
            end
            previous_was_string = false
        else
            if previous_was_string
                operator_index = operators.length()-1
                operators[operator_index] = operators[operator_index] + split
            else
                operators << split
            end 

            previous_was_string = true
        end
    end
    
    # puts @values
    # puts @operators

    switch_calculation_case(operators, values)
end

### main
get_formula