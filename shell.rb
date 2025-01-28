require_relative 'commands'

def back_to_shell
	parse_command
end

def parse_command
	command = gets.chomp.split

	case command[0]
		when 'exit'
			return
		when 'ls'
			Commands.ls_command(argument: command)
			back_to_shell
		when 'cd'
			Commands.cd_command(argument: command)
			back_to_shell
		when 'mkdir'
			Commands.make_dir_command(argument: command)
			back_to_shell
		when 'rmdir'
			Commands.delete_dir_command(argument: command)
			back_to_shell
		when 'read'
			Commands.read_file_command(argument: command)
			back_to_shell
		when 'rename'
			Commands.rename_file_command(argument: command)
			back_to_shell
		when 'cowsay'
			Commands.cowsay_command(argument: command)
			back_to_shell
		else 
			puts 'invalid command'
			back_to_shell
		end
end



parse_command