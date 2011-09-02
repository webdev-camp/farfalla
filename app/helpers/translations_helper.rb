module TranslationsHelper

  def keys from , pre = nil
    return [] unless from
    puts "From - #{from}"
    from = (pre == nil) ? from : from[ (pre.length + 1 ) , from.length]
    pre = (pre == nil ) ? "" : "#{pre}."
    all = from.split(".").reverse
    ret = [[prefix = all.pop , "#{pre}#{prefix}" ]]
    all.reverse.each do |k|
      prefix =  "#{prefix}.#{k}"      
      ret << [k , "#{pre}#{prefix}"]
    end
    ret
  end

  if Rails.env != "test"
    def t( key  )
      translate_link(key)
    end
  end
  def translate_link key  
    return "" if Rails.env == "test"
    I18n.t(key ) + link_to( " e" , edit_translation_url( "#{I18n.locale}.#{key}" , :return => request.fullpath))
  end

end
