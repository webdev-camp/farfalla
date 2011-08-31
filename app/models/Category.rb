class Category
  attr_accessor :tag , :file , :children
  
  def initialize tag , file , hash
    @file = file 
    @tag = tag 
    @children = []
    hash.each do |key , value|
      @children << 
        if value.class == Hash
          Category.new "#{tag}.#{key}" , file , value
        else
          Translation.new "#{tag}.#{key}" , file , value 
        end
    end
  end
end
