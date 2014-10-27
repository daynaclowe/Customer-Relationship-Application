require_relative './contact.rb' #
require_relative './rolodex.rb'
require_relative './terminalcolours.rb'

class CRM
	attr_reader :name, :the_contact #getter funct new needs initizalize to be used further in the app

	def initialize(name)
		@name = name
		@rolodex = Rolodex.new
	end

	def main_menu
		puts "Welcome to #{@name}".blue #an instance variable name is defnd inside the class, they are internal values of the class 
		while true
			print_main_menu
			input= gets.chomp.to_i
			return if input == 7
			choose_option(input) 
		end
	end

	def print_main_menu
		puts "[1] Add a Contact".cyan
		puts "[2] Modify a Contact".cyan
		puts "[3] Display All Contacts".cyan
		puts "[4] Display One Contact".cyan
		puts "[5] Display an Attribute".cyan
		puts "[6] Delete a Contact".cyan
		puts "[7] Exit".cyan
		puts "Select an option by typing in its corresponding number:".pink
	end

	def choose_option(option)
		case option
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_all_contacts
		when 4 then display_one_contact
		when 5 then display_attribute
		when 6 then delete_contact
		when 7
			puts "Goodbye!"
			return
		else 
			puts "Invalid Option!".red
		end
		end # main_menu - will loop but will fucntion into functions too deep ie stack to deep - refer to the while loop
	end

	def add_contact
		print "First Name: ".pink
		first_name = gets.chomp
		print "Last Name: ".pink
		last_name = gets.chomp
		print "Email :".pink
		email = gets.chomp
		print "Note :".pink
		note = gets.chomp #could use a hash but it is not ideal - if you need a cutstom piece of data to be repeated you need to create a new class for that method to call on
		
		contact = Contact.new(first_name, last_name, email, note)
		@rolodex.add_contact(contact)
		
	end

	def modify_contact
		puts "Please provide your user id - if you don't know your id type --get ".pink
		input = gets.chomp
		if input == "get"
			display_all_contacts
		else
			contact_id = input.to_i
			@the_contact = @rolodex.get_contact_by_id(contact_id)

			while true
				print_modify_contact_menu
				input = gets.chomp.to_i
				return if input == 5
				print "You have chosen to update option #{input}. Press Y to continue updating or N to change your selection.".pink
				answer = gets.chomp.capitalize
				if answer == "Y"
					choose_option_from_modify_contact_menu(input) 
				elsif answer == "N"
					puts "Please choose another option."
				else 
					puts "That's not an option. Please choose another option and confirm your selection."  #want this to loop back around so the user can only choose yes or no
				end
			end
		end
	end

	def print_modify_contact_menu
		puts "[1] Update first name.".cyan
		puts "[2] Update last name.".cyan
		puts "[3] Update email.".cyan
		puts "[4] Update note.".cyan
		puts "[5] Return to main menu".cyan
		puts "Enter a number 1 - 5".pink

	end

	def choose_option_from_modify_contact_menu(option) 
		case option
		when 1 	
			print "Update First Name: ".pink
			new_first_name = gets.chomp
			the_contact.first_name = new_first_name
			puts "You have sucessfully updated your first name to: #{the_contact.first_name}".red 
			puts "Choose [5] if you wish to return to the main menu, or another option to continue making changes." 
		when 2 
			print "Update Last Name: ".pink
			new_last_name = gets.chomp
			the_contact.last_name = new_last_name
			puts "You have sucessfully updated your last name to: #{the_contact.last_name}".red 
			puts "Choose [5] if you wish to return to the main menu, or another option to continue making changes." 
		when 3 
			print "Update Email: ".pink
			new_email = gets.chomp
			the_contact.email = new_email
			puts "You have sucessfully updated your email to: #{the_contact.email}".red 
			puts "Choose [5] if you wish to return to the main menu, or another option to continue making changes." 
		when 4 then 
			print "Update Note: ".pink
			new_note = gets.chomp
			the_contact.note = new_note
			puts "You have sucessfully updated your note to: #{the_contact.note}".red 
			puts "Choose [5] if you wish to return to the main menu, or another option to continue making changes." 

		@rolodex.update_contact(the_contact) #the_contact is a local variable of modify_contact but i need it to also be local to this method
		#need an statement for when no number or letters are chosen instead - tried and reads back as you have selected option 0
		
	end 

	def display_all_contacts
		@rolodex.contacts.each do |contact|
			puts "#{contact.first_name} #{contact.last_name} <#{contact.email}> #{contact.id}"
		end
	end

	def display_one_contact
		puts "Please choose how you would like to search."
			print_display_one_contact_menu
			input = gets.chomp.to_i
			return if input == 5
			print "You have chosen to search via option #{input}.".pink
			display_one_contact_search_by(input)
			
		end
	end
	

	def print_display_one_contact_menu
		puts "[1] Search by first name.".cyan
		puts "[2] Search by last name.".cyan
		puts "[3] Search by email.".cyan
		puts "[4] Search by id.".cyan
		puts "[5] Return to main menu".cyan
		puts "Enter a number 1 - 5".pink
	end

	def display_one_contact_search_by(option)
		case option
		when 1 	
			print "What is their first name? ".pink
			first_name = gets.chomp
			contact.first_name = @rolodex.search_contact_by(first_name)
		when 2 
			print "What is their last name? ".pink
		when 3 
			print "What is their email? ".pink
		when 4 then 
			print "What is their id? ".pink

	end

end

crm = CRM.new("BitmakerLabs") #instance of object crm - one instance of the object
crm.main_menu
