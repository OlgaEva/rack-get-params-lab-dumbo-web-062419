class Application
  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)  

    elsif req.path.match(/cart/)
        if @@cart == []
          resp.write "Your cart is empty"
        else
          @@cart.each do |cart|
          resp.write "#{cart}\n"
          end
        end

    elsif req.path.match(/add/)
      item = req.params["item"]
        if @@items.include?(item)
           @@cart << item
           resp.write "added #{item}"
        else
           resp.write "We don't have that item"
        end
      end        
    resp.finish
end
end
