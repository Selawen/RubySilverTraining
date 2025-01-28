require_relative 'person'

begin
  file = open('./person_data.csv')
  puts 'File opened successfully' if file
rescue Errno::ENOENT
  puts 'File does not exist'
rescue Errno::EACCES
  puts 'The file got the wrong permissions'
end

def read_file(filename)
    @lines = Array.new
    
    return unless File.exist?(filename)

    File.open(filename, 'r') do |file|
        file.readlines.each do |line|
             @lines << line
             #puts line
        end
    end
end

def import_people
    return unless read_file('./person_data.csv')
    @people = Array.new

    @lines.each do |line|
        person_data = line.split(',')
        @people << Person.new(person_data[0], person_data[1], person_data[2], person_data[3])
    end
end

def print_people
    puts 'all people: ' 
    @people.each do |person|
        puts person.get_name
    end
end

def print_adults
    puts 'adults only: ' 
    @people.each do |person|
        puts person.get_name if person.is_adult
    end
end

def sort_by_age
    @people.sort_by!(&:age)
end

import_people
sort_by_age
print_people
print_adults