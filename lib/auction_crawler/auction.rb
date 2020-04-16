class Auction

    #### Attributes ####
    attr_accessor :auction_list, :character_list, :current_displayed_items

    #### Instance Methods ####
    def initialize
        runner = InfoRunner.new
        @auction_list = runner.get_auction_list
        create_items_from_auction_list
        # menu
    end

    def create_items_from_auction_list
        # create items from @auction_list
        @auction_list["auctions"].each do |list_item|
            AuctionItem.find_or_create_by_id(list_item["id"],list_item["item"]["id"])
        end
    end

    def display_list(idx1=0, idx2=9)
        @current_displayed_items = AuctionItem.all[idx1..idx2]
        @current_displayed_items.each do |item|
            puts "#{idx1+1}) #{item.name} #{item.subclass} #{item.level}"
        end
    end

    def menu
        input = nil
        until input == "/[eE]/xit"
            puts "Please type a command or number of item you wish to see more detail on."
            input = validate_input(gets)

            case input
            when 1..10
                display_item(@current_displayed_items[input-1])
            end
        end
    end

    def validate_input(usr_input)
        if usr_input <= 0 || usr_input > 10
            puts "Invalid choice."
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
