require_relative './contact.rb' #
require_relative './rolodex.rb'

class CRM
	attr_reader :name #getter funct new needs initizalize to be used further in the app

	def initialize(name)
		@name = name
		@rolodex = Rolodex.new


	end

	def print_main_menu
		puts "[1] Please add a contact."
		puts "[2] Modify a contact"
		puts "[3] Display all contacts"
		puts "[4] Display one contact"
		puts "[5] Display an attribute"
		puts "[6] Delete a contact"
		puts "[7] Exit"
		puts "Enter a number:"
	end


	def main_menu
		puts "Welcome to #{@name}" #an instance variable name is defnd inside the class, they are internal values of the class 
		while true
			print_main_menu
			input = gets.chomp.to_i
			return if input == 7
			choose_option(input) 
		end
	end


	def choose_option(option)
		case option
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_all_contacts
		when 4 then display_contact
		when 5 then dispaly_attribute
		when 6 then delete_contact
		when 7
			puts "Goodbye!"
			return
		else 
			puts "Invalid Option!"
		end
		# main_menu - will loop but will fucntion into functions too deep ie stack to deep - refer to the while loop
	end


	def add_contact
		print "First Name: "
		first_name = gets.chomp
		print "Last Name: "
		last_name = gets.chomp
		print "Email :"
		email = gets.chomp
		print "Note :"
		note = gets.chomp #could use a hash but it is not ideal - if you need a cutstom piece of data to be repeated you need to create a new class for that method to call on
		
		contact = Contact.new(first_name, last_name, email, note)
		@rolodex.add_contact(contact)
		
	end

	def print_modify_contact_menu
		puts "[1] Update first name."
		puts "[2] Update last name."
		puts "[3] Update email."
		puts "[4] Update note."
		puts "[5] Return to main menu"
		puts "Enter a number 1 - 4"

	end

	def modify_contact
		puts "Please provide your user id - if you don't know your id type --get "
		input = gets.chomp
		if input == "get"
			display_all_contacts
		else
			contact_id = input.to_i
			the_contact = @rolodex.get_contact_by_id(contact_id)

			while true
				print_modify_contact_menu
				input = gets.chomp.to_i
				return if input == 5
				print "You have chosen to update option #{input}. Press Y to continue updating or N to return to the main menu."
				answer = gets.chomp.capitalize
				if answer == "Y"
					choose_option_from_modify_contact_menu(input) 
				elsif answer == "N"
					puts "You will now exit this window."
					return
				else  
					puts "That's not an option. Please choose Y or N."

				end
				# @rolodex.update_contact(the_contact)
			end




			# puts "[1] Update first name."
			# puts "[2] Update last name."
			# puts "[3] Update email."
			# puts "[4] Update note."
			# puts "Enter a number 1 - 4"
			# input = gets.chomp.to_i
			# print "You have chosen to update your first name. Press Y to continue updating or N to return to the main menu."
			# answer = gets.chomp.capitalize
			# if answer == "Y"
			# 	case input

			# 	when 1 
			# 		print "Update First Name: "
			# 		new_first_name = gets.chomp
			# 		the_contact.first_name = new_first_name
			# 	when 2
			# 		print "Update Last Name: "
			# 		new_last_name = gets.chomp
			# 		the_contact.last_name = new_last_name
			# 	when 3
			# 		print "Update Email: "
			# 		new_email = gets.chomp
			# 		the_contact.email = new_email
			# 	when 4
			# 		print "Update Note: "
			# 		new_note = gets.chomp
			# 		the_contact.note = new_note

			# 	end
			# elsif answer == "N"
			# 	puts "You will now exit this window."
			# 	return
			# else  
			# 	puts "That's not an option. Please choose Y or N."

			# end

			# @rolodex.update_contact(the_contact)
			# when 2 
			# 	print "Update Last Name: "
			# 	last_name = gets.replace
			# when 3 
			# 	print "Update Email :"
			# 	email = gets.replace
			# when 4  
			# 	print "Update Note :"
			# 	note = gets.replace
		# else puts "That's not right. Choose an option 1 - 4"
		# 	#puts "Your updated information is: #{contact.first_name} #{contact.last_name} <#{contact.email}> #{contact.id}"
		# end
	end
end

	def choose_option_from_modify_contact_menu(option) 
		# print "You have chosen to update #{option}. Press Y to continue updating or N to return to the main menu."
		# input = gets.chomp.capitalize
		# if option == "Y"

		case option
		when 1 #then update_first_name
				print "Update First Name: "
				new_first_name = gets.chomp
				the_contact.first_name = new_first_name
			when 2 then update_last_name
				# print "Update Last Name: "
				# new_last_name = gets.chomp
				# the_contact.last_name = new_last_name
			when 3 then update_email
				# print "Update Email: "
				# new_email = gets.chomp
				# the_contact.email = new_email
			when 4 then update_note
				# print "Update Note: "
				# new_note = gets.chomp
				# the_contact.note = new_note

			end

			@rolodex.update_contact(the_contact) #the_contact is a local variable of modify contact but i need it to also be local to this method
	end

def attribute
end

def display_all_contacts
	@rolodex.contacts.each do |contact|
		puts "#{contact.first_name} #{contact.last_name} <#{contact.email}> #{contact.id}"
	end
end
end
		# puts "input at choose_option: #{option}"
		# option = 12
		# puts "input at choose_option (after change) #{option}"


crm = CRM.new("BitmakerLabs") #instance of object crm - one instance of the object
crm.main_menu
