require 'spec_helper'

describe Insightly2::DSL::Contacts do
  let(:contact_id) { 243779461 }

  # GET /v2.2/Contacts/{id}
  describe '#get_contact' do
    it 'returns a contact' do
      VCR.use_cassette('get_contact') do
        expect(Insightly2.client.get_contact(id: contact_id)).to be_a(Contact)
      end
    end
  end

  # GET /v2.1/Contacts/{c_id}/Emails
  describe '#get_contact_emails' do
    it 'returns a contacts emails' do
      VCR.use_cassette('get_contact_emails') do
        emails = Insightly2.client.get_contact_emails(id: contact_id)
        expect(emails).to be_a(Array)
        expect(emails.first).to be_a(Email)
      end
    end
  end

  # GET /v2.1/Contacts/{c_id}/Notes
  describe '#get_contact_notes' do
    it 'returns a contacts notes' do
      VCR.use_cassette('get_contact_notes') do
        notes = Insightly2.client.get_contact_notes(id: contact_id)
        expect(notes).to be_a(Array)
        expect(notes.first).to be_a(Note)
      end
    end
  end

  # GET /v2.1/Contacts/{c_id}/Tasks
  describe '#get_contact_tasks' do
    it 'returns a contacts tasks' do
      VCR.use_cassette('get_contact_tasks') do
        tasks = Insightly2.client.get_contact_tasks(id: contact_id)
        expect(tasks).to be_a(Array)
        expect(tasks.first).to be_a(Task)
      end
    end
  end

  # GET /v2.1/Contacts/{c_id}/Image
  # describe '#get_contact_image' do
  #   it 'returns a contacts image' do
  #     VCR.use_cassette('get_contact_image') do
  #       response = Insightly2.client.get_contact_image(id: contact_id)
  #       # expect(response.status).to eq(200)
  #       # TODO - Insightly2 server error with default contact image they should fix this.
  #     end
  #   end
  # end

  # GET /v2.1/Contacts?ids={ids}&email={email}&tag={tag}
  # GET /v2.2/Contacts/Search
  describe '#get_contacts' do
    it 'returns an array of contacts' do
      VCR.use_cassette('get_contacts') do
        contacts = Insightly2.client.get_contacts
        expect(contacts).to be_a(Array)
        expect(contacts.first).to be_a(Contact)
      end
    end

    it 'returns an array which contains Chris Chen' do
      VCR.use_cassette('search_specific_contacts') do
        contacts = Insightly2.client.get_contacts(query: {brief: false, top: 10, skip: 0, count_total: false, last_name: 'Chen'})
        expect(contacts).to be_a(Array)
        expect(contacts.first).to be_a(Contact)
        expect(contacts.first.last_name).to eql('Chen')
      end
    end
  end

  # POST /v2.1/Contacts
  describe '#create_contact' do
    it 'creates and returns contact' do
      VCR.use_cassette('create_contact') do
        expect(Insightly2.client.create_contact(contact: { first_name: 'Shark', last_name: 'Nado' })).to be_a(Contact)
      end
    end
  end

  # Post /2.2/Contacts/{c_id}/Tags
  describe '#create_a_contact_tag' do
    it 'creates and return a contact tag' do
      VCR.use_cassette('create_contact_tag') do
        expect(Insightly2.client.create_contact_tag(contact_id: contact_id, tag: {"TAG_NAME" => 'GoodMan'})).to be_a(Contact)
      end
    end
  end

  # POST /v2.1/Contacts/{c_id}/Image/{filename}
  # describe '#create_contact_image' do
  #   it 'returns a response with code 201' do
  #     VCR.use_cassette('create_contact_image') do
  #       response = Insightly2.client.create_contact_image(id: contact_id, filename: '1.jpg')
  #       # expect(response.status).to eq(201)
  #       # TODO - Can't add image. Not sure why.
  #     end
  #   end
  # end

  # PUT /v2.2/Contacts
  describe '#update_contact' do
    it 'updates and returns contact' do
      VCR.use_cassette('update_contact') do
        contact = Insightly2.client.get_contact(id: contact_id)
        expect(Insightly2.client.update_contact(contact: contact)).to be_a(Contact)
      end
    end

    it 'partial updates and returns contact' do
      VCR.use_cassette('update_contact_partial') do
        contact = Insightly2.client.get_contact(id: contact_id)
        expect(Insightly2.client.update_contact(contact: contact, brief: true)).to be_a(Contact)
      end
    end
  end

  # PUT /v2.2/Contacts/{id}/ContactsInfos
  describe '#upate_contact_info' do
    it 'updates and return contact info' do
      VCR.use_cassette('update_contact_info') do
        contact = Insightly2.client.get_contact(id: contact_id)
        expect(Insightly2.client.update_contact_info(contact_id: contact_id, info: contact.contactinfos.first )).to be_a(Contact)
      end
    end
  end

  # PUT /v2.2/Contacts/{c_id}/Addresses
  describe '#update_contact_address' do
    it 'updates and return contact address' do
      VCR.use_cassette('update_contact_address') do
        contact = Insightly2.client.get_contact(id: contact_id)
        expect(Insightly2.client.update_contact_address(contact_id: contact_id, address: contact.addresses.first)).to be_a(Contact)
      end
    end
  end

  # PUT /v2.2/Contacts/{c_id}/Links
  describe '#update_contact_link' do
    it 'updates and return contact link' do
      VCR.use_cassette('update_contact_link') do
        contact = Insightly2.client.get_contact(id: contact_id)
        expect(Insightly2.client.update_contact_link(contact_id: contact_id, link: contact.links.first)).to be_a(Contact)
      end
    end
  end

  # PUT /v2.2/Contacts/{c_id}/CustomFields
  describe '#update_a_contact_custom_field' do
    it 'updates and return a contact custom_field' do
      VCR.use_cassette('update_contact_custom_field') do
        contact = Insightly2.client.get_contact(id: contact_id)
        expect(Insightly2.client.update_contact_custom_field(contact_id: contact_id, custom_field: contact.customfields.first)).to be_a(Contact)
      end
    end
  end

  # PUT /v2.1/Contacts/{c_id}/Image/{filename}
  # describe '#update_contact_image' do
  #   it 'returns a response with code 201' do
  #     VCR.use_cassette('update_contact_image') do
  #       response = Insightly2.client.update_contact_image(id: contact_id, filename: '1.jpg')
  #       # expect(response.status).to eq(201)
  #       # TODO - Can't update image. Not sure why.
  #     end
  #   end
  # end

  # DELETE /v2.1/Contacts/{id}
  describe '#delete_contact' do
    it 'returns a response with code 202' do
      VCR.use_cassette('delete_contact') do
        response = Insightly2.client.delete_contact(id: contact_id)
        expect(response.status).to eq(202)
      end
    end
  end

  # DELETE /v2.2/Contacts/{c_id}/Tags/{tagName}
  describe '#delete_contact_tag' do
    it 'returns a response with code 202' do
      VCR.use_cassette('delete_contact_tag') do
        response = Insightly2.client.delete_contact_tag(contact_id: contact_id, tag_name: 'GoodMan')
      end
    end
  end

  # DELETE /v2.1/Contacts/{c_id}/Image
  describe '#delete_contact_image' do
    it 'returns a response with code 202' do
      VCR.use_cassette('delete_contact_image') do
        response = Insightly2.client.delete_contact_image(id: contact_id)
        expect(response.status).to eq(202)
      end
    end
  end
end
