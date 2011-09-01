class Translation < Category
  
  attr_accessor  :text  
  
  def initialize tag , file  , text 
    super( tag , file )
    @text = text || ""
  end

end
