class Auction

    #### Attributes ####
    attr_accessor :auction_list, :character_list

    #### Instance Methods ####
    def initialize
        runner = InfoRunner.new
        @auction_list = JSON.parse(runner.get_auction_list.body)
    end

    #### Class Methods####

end
