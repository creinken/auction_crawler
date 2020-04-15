class Auction

    #### Attributes ####
    attr_accessor :auction_list, :character_list

    #### Instance Methods ####
    def initialize
        runner = InfoRunner.new
        @auction_list = runner.get_auction_list
        puts JSON.parse(@auction_list.body)
    end

    #### Class Methods####

end
