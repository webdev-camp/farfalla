module ApplicationHelper  
  def this_page
    page = params["page"] || "index"
     "/#{page}.html"
  end
  
  def photos
    dir "photos"
  end
  
  def activities
    dir "activities"
  end

  def news
    dir "news"
  end
  
  def dir name
    I18n.t("#{name}.all" , :locale => :en ).split(",").collect do |n| n.strip end
  end
  
  def t( key  )
    ret = I18n.t(key)
    "#{ret} <a href='/translations/?key=#{key}&return=#{this_page}'>e</a>"
  end
  
end
