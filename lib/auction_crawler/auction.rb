class Auction

    #### Attributes ####
    attr_accessor :auction_list, :character_list, :current_displayed_items, :runner

    #### Instance Methods ####
    def initialize
        # call displayed items initialization, create a new InfoRunner, use
        # runner to get the current auction list from Blizzard and create items
        # from the auction list
        self.init_dis_items
        @runner = InfoRunner.new
        @auction_list = runner.get_auction_list
    end

    def find_or_create_items_from_auction_list(idx1,idx2)
        # create items from @auction_list 10 at a time to minimize initial loading
        self.auctions[idx1..idx2].each do |list_item|
            AuctionItem.find_or_create_by_id(list_item['id'],@runner.get_item_by_id(list_item['item']['id']))
        end
        AuctionItem.all[idx1..idx2]
    end

    def auctions
        # return the "auctions" array of hashes from @auction_list
        @auction_list["auctions"]
    end

    def display_list
        # get a 10 item chunk by index from AuctionItem.all
        self.find_or_create_items_from_auction_list(@current_displayed_items[0],@current_displayed_items[1]).each_with_index do |item, inx|
            puts "#{inx+1}) #{item.name} #{item.item_subclass} #{item.level}"
        end
    end

    def call
        # main menu
        input = ""
        self.display_list
        until input == "exit"
            puts "Please type a command or number of item you wish to see more detail on."
            puts "Type list for a list of available commands."
            input = gets.chomp
            int_input = input.to_i
            if int_input != 0
                case int_input
                when 1..10
                    self.display_item(self.get_cdi[int_input-1])
                else
                    puts "Invalid input"
                end
            else
                case input
                when "list"
                    self.display_commands
                # when "next"
                #     self.next_10_items
                # when "prev"
                #     self.previous_10_items
                when "refresh"
                    self.display_list
                end
            end
        end
    end

    def display_item(item)
        # display a formated more detailed listing of the given auction item
        puts "Name: #{item.name}   Item Level: #{item.level}"
        puts "Item Class: #{item.item_class}"
        puts "Item Subclass: #{item.item_subclass}"
        puts "Quality: #{item.quality}"
    end

    def display_commands
        # displays all the currently viable commands
        puts "1-10 - picks an item to view more details"
        puts "list - display this list of commands"
        # puts "next - display the next 10 auction items"
        # puts "prev - display the previous 10 auction items"
        puts "refresh - shows the current list of 10 auction items"
        puts "exit - exits the program"
    end

    # def next_10_items
    #     # adjust stored indexes of the currently displayed items to be the next
    #     # 10 items
    #     @current_displayed_items[0] += 10
    #     @current_displayed_items[1] += 10
    #
    #     # check to see if there are any more items in the AuctionItem.all list.
    #     # if there aren't set the stored index array back to what it was.
    #     if self.auctions.length < (@current_displayed_items[0] + 1)
    #         puts "no more items to display"
    #         @current_displayed_items[0] -= 10
    #         @current_displayed_items[1] -= 10
    #     elsif self.auctions.length <= @current_displayed_items[1]
    #         @current_displayed_items[1] = self.auctions.length-1
    #         self.find_or_create_items_from_auction_list(@current_displayed_items[0],@current_displayed_items[1])
    #         self.display_list
    #     else
    #         self.find_or_create_items_from_auction_list(@current_displayed_items[0],@current_displayed_items[1])
    #         self.display_list
    #     end
    # end
    #
    # def previous_10_items
    #     # adjust stored indexes of the currently displayed items to be the previous
    #     # 10 items
    #     @current_displayed_items[0] -= 10
    #     @current_displayed_items[1] -= 10
    #
    #     # check to see if the stored index number is less than 0 and therefore
    #     # out of bounds. if so reinitialize stored index array.
    #     if @current_displayed_items[0] < 0
    #         self.init_dis_items
    #     end
    #     self.display_list
    # end

    def init_dis_items
        #creates stored index array used for displaying auction items
        @current_displayed_items = [0,9]
    end

    def get_cdi
        # gets a 10 item chunk of auction items from all the auction items
        AuctionItem.all[@current_displayed_items[0]..@current_displayed_items[1]]
    end

end
