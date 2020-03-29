class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            item_instance = detect_item_by_name(item_name)
            if item_instance
                resp.write "#{get_item_price(item_instance)}"
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end

    def get_item_price(item)
        item.price
    end

    def detect_item_by_name(item_name)
        all_items.detect {|item| item.name == item_name}
    end

    def all_items
        Item.all
    end
end