require 'spec_helper'

describe Insightly2::Resources::Contact do
  subject(:contact) do
    VCR.use_cassette('get_contact') do
      Insightly2.client.get_contact(id: 243779461)
    end
  end

  describe 'instance' do
    it 'is decorated with Contact object' do
      expect(subject).to be_a(described_class)
    end

    %w(contact_id salutation first_name last_name background image_url default_linked_organisation
       visible_to visible_team_id visible_user_ids addresses contactinfos dates tags links contactlinks
       can_edit can_delete social_linkedin social_facebook social_twitter assistant_name).each do |method|
      it "responds to #{method}" do
        expect(subject).to respond_to(method)
      end
    end
  end
end
