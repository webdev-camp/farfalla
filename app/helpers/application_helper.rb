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
  
  def groups
    ret = []
    I18n.t( "menu").split(" ").each do |g|
      if(I18n.t("#{g}.sub_menu").index("missing"))
        ret << g
      else
        ret += I18n.t("#{g}.sub_menu").split(" ")
      end
    end
    ret   
  end
end
