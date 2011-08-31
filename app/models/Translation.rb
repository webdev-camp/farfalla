class Translation
  
  attr_accessor :tag , :file , :text  
  
  def initialize tag , file  , text 
    @tag = tag
    @file = file
    @text = text || ""
  end

end
