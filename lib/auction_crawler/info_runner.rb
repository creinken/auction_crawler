class InfoRunner

    #### Attributes ####
    attr_accessor :token, :region, :connectedRealmId, :namespace, :locale

    #### Instance Methods ####
    def initialize
        @token = JSON.parse(get_token.body)
        @region = "us"
        @connectedRealmId = 1146
        @namespace = "dynamic-us"
        @locale = "en_US"

    end

    def get_token
        #### the code below should be equivalent to the following curl ####
        # curl -u 57afd6363525481c996bc55483249d5c:wKH18WdIQfV7Fb4W5m1qg8JU1HwI5iuQ -d grant_type=client_credentials https://us.battle.net/oauth/token

        uri = URI.parse("https://us.battle.net/oauth/token")
        request = Net::HTTP::Post.new(uri)
        request.basic_auth("57afd6363525481c996bc55483249d5c", "wKH18WdIQfV7Fb4W5m1qg8JU1HwI5iuQ")
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
        auction_list = Net::HTTP.get_response(uri)
        JSON.parse(auction_list.body)
    end

    def get_item_by_id(item_id)
        uri = URI.parse("https://#{@region}.api.blizzard.com/data/wow/item/#{item_id}?namespace=static-us&locale=#{@locale}&access_token=#{token['access_token']}")
        item = Net::HTTP.get_response(uri)
        item_json = JSON.parse(item.body)
        item_hash = {
            :name => item_json["name"],
            :quality => item_json["quality"]["name"],
            :level => item_json["level"],
            :item_class => item_json["item_class"]["name"],
            :item_subclass => item_json["item_subclass"]["name"]
        }
    end

    #### Class Methods####

end
