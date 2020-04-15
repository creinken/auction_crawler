class InfoRunner

    #### Attributes ####
    attr_accessor :token, :region, :connectedRealmId, :namespace, :locale

    #### Instance Methods ####
    def initialize
        @token = get_token
        @region = "us"
        @connectedRealmId = 1146
        @namespace = "dynamic-us"
        @locale = "en_US"

    end

    def get_token
        uri = URI.parse("https://us.battle.net/oauth/token")
        request = Net::HTTP::Post.new(uri)
        request.basic_auth("{57afd6363525481c996bc55483249d5c}", "{wKH18WdIQfV7Fb4W5m1qg8JU1HwI5iuQ}")
        request.set_form_data(
          "grant_type" => "client_credentials",
        )

        req_options = {
          use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
    end

    def get_auction_list
        uri = URI.parse("https://#{@region}.api.blizzard.com/data/wow/connected-realm/#{@connectedRealmId}/auctions?namespace=#{@namespace}&locale=#{@locale}&access_token=#{token['access_token']}")
        Net::HTTP.get_response(uri)
    end

    def get_item_by_id

    end

    #### Class Methods####

end
