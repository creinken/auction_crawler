class Auction

    #### Attributes ####
    attr_accessor :auction_list, :character_list, :current_displayed_items, :runner

    #### Instance Methods ####
    def initialize
        self.init_dis_items
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

    def display_list
        AuctionItem.all[@current_displayed_items[0]..@current_displayed_items[1]].each_with_index do |item, inx|
            puts "#{inx+1}) #{item.name} #{item.item_subclass} #{item.level}"
        end
    end

    def call
        input = ""
        self.display_list
        until input == "exit"
            puts "Please type a command or number of item you wish to see more detail on."
            puts "Type list for a list of available commands."
            input = gets.chomp
            if input.to_i != 0
                case input.to_i
                when 1..10
                    display_item(@current_displayed_items[input.to_i-1])
                else
                    puts "Invalid input"
                end
            else
                case input
                when "list"
                    self.display_commands
                when "next"
                    self.next_10_items
                when "prev"
                    self.previous_10_items
                when "refresh"
                    self.display_list
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

    def display_commands
        puts "1-10 - picks an item to view more details"
        puts "list - display this list of commands"
        puts "next - display the next 10 auction items"
        puts "prev - display the previous 10 auction items"
        puts "refresh - shows the current list of 10 auction items"
        puts "exit - exits the program"
    end

    def next_10_items
        @current_displayed_items[0] += 10
        @current_displayed_items[1] += 10
        if AuctionItem.all.length < (@current_displayed_items[0] + 1)
            puts "no more items to display"
        elsif AuctionItem.all.length <= @current_displayed_items[1]
            @current_displayed_items[1] = AuctionItem.all.length-1
        end
        self.display_list
    end

    def previous_10_items
        @current_displayed_items[0] -= 10
        @current_displayed_items[1] -= 10
        if @current_displayed_items[0] < 0
            self.init_dis_items
        end
        self.display_list
    end

    def init_dis_items
        @current_displayed_items = [0,9]
    end

    #### Class Methods####

end
