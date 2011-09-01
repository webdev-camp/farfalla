module TranslationsHelper

  def keys from , pre = nil
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

end
