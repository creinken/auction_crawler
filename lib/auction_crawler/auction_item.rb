class AuctionItem

    #### Attributes ####
    attr_accessor :name, :quality, :level, :item_class, :item_subclass, :auction_id, :item_id
    @@all = []

    #### Instance Methods ####
    def initialize(item_hash)
        # create new item from hash of values passed which can include any or all of the class attributes
        item_hash.each {|key, value| self.send(("#{key}="), value)}
    end

    def save
        # save current instance to array collection of all instances of class AuctionItem
        self.class.all << self
    end

    #### Class Methods####
    def self.find_by_id(auction_id)
        # searches the class variable @@all for an object matching the passed
        # auction_id, returns it if found and nil if not found
        AuctionItem.all.find {|item_obj| item_obj.auction_id == auction_id}
    end

    def self.find_or_create_by_id(auction_id, item_hash)
        # calls find_by_id, tests the result, if it found the item returns it,
        # if find_by_id returned nil then it creates the item with the supplied hash
        if AuctionItem.find_by_id(auction_id).nil?
            AuctionItem.create(item_hash)
        else
            AuctionItem.find_by_id(auction_id)
        end
    end

    def self.all
        @@all
    end

    def self.create(item_hash)
        # calls initialize to create new item with supplied hash and then calls
        # save to save instance to array of all instances and returns instance object
        new_item = self.new(item_hash)
        new_item.save
        puts "Created #{new_item}"
        new_item
    end
end
