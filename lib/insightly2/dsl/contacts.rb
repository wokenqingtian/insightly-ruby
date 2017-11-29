require 'insightly2/dsl'

module Insightly2
  module DSL::Contacts
    # GET /v2.1/Contacts/{id}
    # Gets a contact by id.
    # @param [String, Fixnum] id The ID of the contact.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Insightly2::Resources::Contact, nil].
    def get_contact(id: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Contact.parse(request(:get, "Contacts/#{id}"))
    end

    # GET /v2.1/Contacts/{c_id}/Emails
    # Gets a contact's emails.
    # @param [id:] id of the contact.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Array, nil].
    def get_contact_emails(id: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Email.parse(request(:get, "Contacts/#{id}/Emails"))
    end

    # GET /v2.1/Contacts/{c_id}/Image
    # Gets a contact's image.
    # @param [String, Fixnum] id The ID of the contact.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Faraday::Response].
    def get_contact_image(id: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      request(:get, "Contacts/#{id}/Image")
    end

    # GET /v2.1/Contacts/{c_id}/Notes
    # Gets a contact's notes.
    # @param [String, Fixnum] id The ID of the contact.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Array, nil].
    def get_contact_notes(id: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Note.parse(request(:get, "Contacts/#{id}/Notes"))
    end

    # GET /v2.1/Contacts/{c_id}/Tasks
    # Gets a contact's tasks.
    # @param [String, Fixnum] id The ID of the contact.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Array, nil].
    def get_contact_tasks(id: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      Resources::Task.parse(request(:get, "Contacts/#{id}/Tasks"))
    end

    # GET /v2.2/Contacts/Search
    # Get or Search a list of contacts.
    def get_contacts(query: {})
      url = Utils::UrlHelper.build_url(path: "Contacts/Search", params: query) 
      Resources::Contact.parse(request(:get, url))
    end

    # POST /v2.1/Contacts
    # Creates a contact.
    # @param [Hash] contact The contact to create.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Insightly2::Resources::Contact, nil].
    def create_contact(contact: nil)
      raise ArgumentError, "Contact cannot be blank" if contact.blank?
      Resources::Contact.parse(request(:post, "Contacts", contact))
    end

    # POST /v2.2/Contacts/{c_id}/Tags
    # Creates a contact.
    def create_contact_tag(contact_id: nil, tag: nil)
      raise ArgumentError, "Contact contact_id cannot be blank" if contact_id.blank?
      raise ArgumentError, "Contact tag cannot be blank" if tag.blank?
      Resources::Contact.parse(request(:post, "Contacts/#{contact_id}/Tags", tag))
    end

    # POST /v2.1/Contacts/{c_id}/Image/{filename}
    # Adds a contact's image.
    # @param [String, Fixnum] id The ID of the contact.
    # @param [String] filename The name of image file to be attached to the contact.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Faraday::Response].
    def create_contact_image(id: nil, filename: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      raise ArgumentError, "Filename cannot be blank" if filename.blank?
      request(:post, "Contacts/#{id}/Image/#{filename}")
    end

    # PUT /v2.2/Contacts
    # Updates a contact.
    # @param [Hash] contact The contact to update.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Insightly2::Resources::Contact, nil].
    def update_contact(contact: nil, brief: false)
      raise ArgumentError, "Contact cannot be blank" if contact.blank?
      url = Utils::UrlHelper.build_url(path: "Contacts", params: { brief: brief })
      Resources::Contact.parse(request(:put, url, contact))
    end

    # PUT /v2.2/Contacts/{c_id}/ContactInfos
    # Updates a contact's contact info
    def update_contact_info(contact_id: nil, info: nil)
      raise ArgumentError, "Contact id cannot be blank" if contact_id.blank?
      raise ArgumentError, "Contact info cannot be blank" if info.blank?
      Resources::Contact.parse(request(:put, "Contacts/#{contact_id}/ContactInfos", info))
    end

    # PUT /v2.2/Contacts/{c_id}/Addresses
    # Updates a contact's address
    def update_contact_address(contact_id: nil, address: nil)
      raise ArgumentError, "Contact id cannot be blank" if contact_id.blank?
      raise ArgumentError, "Contact addresses cannot be blank" if address.blank?
      Resources::Contact.parse(request(:put, "Contacts/#{contact_id}/Addresses", address))
    end

    # PUT /v2.2/Contacts/{c_id}/Links
    # Updates a contact's link
    def update_contact_link(contact_id: nil, link: nil)
      raise ArgumentError, "Contact id cannot be blank" if contact_id.blank?
      raise ArgumentError, "Contact link cannot be blank" if link.blank?
      Resources::Contact.parse(request(:put, "Contacts/#{contact_id}/Links", link))
    end

    # PUT /v2.2/Contacts/{c_id}/CustomFields
    # Updates a contact's custom field
    def update_contact_custom_field(contact_id: nil, custom_field: nil)
      raise ArgumentError, "Contact id cannot be blank" if contact_id.blank?
      raise ArgumentError, "Contact custom field cannot be blank" if custom_field.blank?
      Resources::Contact.parse(request(:put, "Contacts/#{contact_id}/CustomFields", custom_field))
    end

    # PUT /v2.1/Contacts/{c_id}/Image/{filename}
    # Updates a contact's image.
    # @param [String, Fixnum] id The ID of the contact.
    # @param [String] filename The name of image file to be attached to the contact.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Faraday::Response].
    def update_contact_image(id: nil, filename: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      raise ArgumentError, "Filename cannot be blank" if filename.blank?
      request(:put, "Contacts/#{id}/Image/#{filename}")
    end

    # DELETE /v2.1/Contacts/{id}
    # Deletes a contact.
    # @param [String, Fixnum] id The ID of the contact to delete.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Faraday::Response].
    def delete_contact(id: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      request(:delete, "Contacts/#{id}")
    end

    def delete_contact_tag(contact_id: nil, tag_name: nil)
      raise ArgumentError, "Contact id connot be blank" if contact_id.blank?
      request(:delete, "Contacts/#{contact_id}/tags/#{tag_name}")
    end

    # DELETE /v2.1/Contacts/{c_id}/Image
    # Deletes a contact's image.
    # @param [String, Fixnum] id The ID of the contact with the image to delete.
    # @raise [ArgumentError] If the method arguments are blank.
    # @return [Faraday::Response].
    def delete_contact_image(id: nil)
      raise ArgumentError, "ID cannot be blank" if id.blank?
      request(:delete, "Contacts/#{id}/Image")
    end
  end
end
