class Item

    #### Attributes ####

    @@all = []

    #### Instance Methods ####
    def initialize

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

    def self.create()

    end
end
