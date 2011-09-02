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
  
  def has_sub key
    return true if edit_mode
    ret = t(key)
    return false if ret.index "missing"
    ! key.strip.empty?
  end
  
  def edit_mode
    Rails.env != "test"
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
    ret.sort
  end
end
