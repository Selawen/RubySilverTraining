module Commands

def self.cowsay_command(argument:)
	@message = ''
	puts '________________________________________'
	for index in 1..(argument.length-1)
		@message = [@message, argument[index]].join(' ')
	end
	puts @message
	puts '________________________________________'
	puts '   \   ^__^'
    puts '    \  (oo)\_______'
    puts '       (__)\       )\/\\'
    puts '           ||----w |'
    puts '           ||     ||'

end

def self.ls_command(argument:)
	case argument[1]
		when '-l'
			puts Dir.entries('.')
		else 
			puts Dir.entries('.').join(' ')
		end
end

def self.cd_command(argument:)
	case argument[1]
		when nil
			puts 'no directory given'
		else
			begin
				Dir.chdir(argument[1])
			rescue Errno::ENOENT
				puts 'directory doen not exist'
			else 
				puts Dir.pwd
			end

	end
end

def self.read_file_command(argument:)
	case argument[1]
		when nil
			puts 'no file given'
		else
			begin
				File.open(argument[1], 'r') do |file|
					puts file.read
			end
			rescue Errno::ENOENT
				puts 'file does not exist'
			rescue Errno::EACCES
				puts "no read permission for #{argument[1]}"
			end

	end
end

def self.rename_file(argument:)
	begin
		File.rename(argument[1], argument[2])
	end
	rescue Errno::ENOENT
		puts 'file does not exist'
	rescue Errno::EACCES
		puts "no rename permission for #{argument[1]}"
	else 
		puts "file renamed to #{argument[2]}"
	
end

def self.rename_dir(argument:)
	begin
		File.rename(argument[1], argument[2])
	rescue Errno::ENOENT
		puts 'directory does not exist'
	rescue Errno::EACCES
		puts "no rename permission for #{argument[1]}"
	else 
		puts "directory renamed to #{argument[2]}"
	end
		
end

def self.rename_file_command(argument:)
	
	if (argument[1] == nil || argument[2] == nil )
			puts 'no path and/or new name given'
			return
	end

	case argument[1]
		when nil
			puts 'no path given'
		else
			begin
				File.directory?(argument[1])? rename_dir(argument: argument) : rename_file(argument: argument)
			rescue StandardError => e
					puts e.message
			end
	end
end

def self.make_dir_command(argument:)
	case argument[1]
		when nil
			puts 'no directory name given'
		else
			for index in 1..(argument.length-1)
				begin
					Dir.mkdir(argument[index])
				rescue StandardError => e
					puts e.message
				else 
					puts [Dir.pwd, argument[index]].join('/')
				end
			end
		end
end

def self.delete_dir_command(argument:)
	case argument[1]
		when nil
			puts 'no directory path given'
		else
			for index in 1..(argument.length-1)
				begin
					Dir.delete(argument[index])
				rescue StandardError => e
					puts e.message
				else 
					puts "deleted #{argument[index]}"
				end
			end
		end
end

end