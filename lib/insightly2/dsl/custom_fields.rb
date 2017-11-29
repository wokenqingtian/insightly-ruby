require 'insightly2/dsl'

module Insightly2
  module DSL::CustomFields

    # GET /v2.2/CustomFields
    # Get a list of custom fields.
    # @return [Array, nil].
    def get_custom_fields(query={})
      url = Utils::UrlHelper.build_url(path: 'CustomFields', params: query)
      Resources::CustomField.parse(request(:get, url))
    end
  end
end
