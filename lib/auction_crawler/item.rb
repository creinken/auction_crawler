class Item

    #### Attributes ####

    @@all = []

    #### Instance Methods ####
    def initialize(item_hash)
        item_hash.each {|key, value| self.send(("#{key}="), value)}
    end

    def save
        self.class.all << self
    end

    #### Class Methods####
    def self.find_by_id(id)
        Item.all.find {|item_obj| item_obj.id == id}
    end

    def self.find_or_create_by_id(id)
        if find_by_id(id).nil?
            self.create(id)
        else
            find_by_id(id)
        end
    end

    def self.create(item_hash)
        new_item = self.new(item_hash)
        new_item.save
        new_item
    end
end
