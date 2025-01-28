class Person
attr_accessor :first_name
attr_accessor :last_name
attr_accessor :age
attr_accessor :city

attr_accessor :is_adult

def initialize(first_name, last_name, age, city)
	@first_name = first_name
    @last_name = last_name	
    @age = age.to_i
    @city = city

    @is_adult = (age.to_i >= 18)
end

def get_name 
    name = @first_name + ' ' + @last_name
end

end