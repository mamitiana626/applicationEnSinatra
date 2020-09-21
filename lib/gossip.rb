class Gossip

  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
    
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def delete(id)
    arr_of_arrs = CSV.read("db/gossip.csv")
    arr_of_arrs.delete_at(id)
    #arr_of_arrs.delete_at(params[:id].to_i)

    CSV.open("./db/gossip.csv", "wb") do |csv|
        arr_of_arrs.each do |x, y|
            csv << [x, y]
        end
    end
  end

  def self.all
  	gossip_array = []
	 	CSV.read("./db/gossip.csv").each do |line|
		 	gossip_array << Gossip.new(line[0],line[1])
		end

 		return gossip_array
  end
  
  def self.find(id)
    return Gossip.all[id]
  end

end