class Rolodex
	attr_reader :contacts
	@@index= 1000 #we dont store the unique identifier in the menu because of it's purpose, we don't store it in the contact because it only. if it is done in an instance variable if there are multiple roladexes they won't be globally unique. If we make it a class level variable every contact, regardless of how many rolodexes 

	def initialize#(contacts)
		@contacts = [] #if we have different contacts with the same name we need to add another value to give each contact a unique identifier to differentiate between them
	end	

	def add_contact(contact)
		contact.id = @@index #set the id for the contact
		@@index +=1 #increment the global index
		@contacts << contact #add the contact onto the list
	end

	def get_contact_by_id(contact_id)
		@contacts.each do |contact| 
			if (contact.id == contact_id)
				return contact 
			end 
		end
	end

	def update_contact(contact_to_update)
		@contacts.each_with_index do |contact, index| 
			if (contact.id == contact_to_update.id)
				@contacts[index] = contact_to_update
			end
		end
	end

end

