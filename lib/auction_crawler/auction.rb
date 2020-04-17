class Auction

    #### Attributes ####
    attr_accessor :auction_list, :character_list, :current_displayed_items, :runner

    #### Instance Methods ####
    def initialize
        @runner = InfoRunner.new
        @auction_list = runner.get_auction_list
        self.create_items_from_auction_list
    end

    def create_items_from_auction_list
        # create items from @auction_list
        @auction_list["auctions"].take(10).each do |list_item|
            AuctionItem.find_or_create_by_id(list_item['id'],@runner.get_item_by_id(list_item['item']['id']))
        end
    end

    def display_list(idx1=0, idx2=9)
        @current_displayed_items = AuctionItem.all[idx1..idx2]
        @current_displayed_items.each_with_index do |item, inx|
            puts "#{inx+1}) #{item.name} #{item.item_subclass} #{item.level}"
        end
    end

    def call
        input = nil
        self.display_list
        until input == 'exit'
            puts "Please type a command or number of item you wish to see more detail on."
            input = gets
            if input.to_i != 0
                case input.to_i
                when 1..10
                    display_item(@current_displayed_items[input.to_i-1])
                else
                    puts "Invalid input"
                end
            end
        end
    end

    def display_item(item)
        puts "#{item.name}   #{item.level}"
        puts "#{item.item_class}"
        puts "#{item.item_subclass}"
        puts "#{item.quality}"
    end

    # display first 10 auction items and ask user for input
    # when user enters a command validate and perform command

    #### Class Methods####

end
