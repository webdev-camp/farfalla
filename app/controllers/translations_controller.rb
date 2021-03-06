class TranslationsController < ApplicationController
  
  def index
    @files = all_files
    load_all_translations
    depth_filter 2
  end
  def missing
    locale = params[:id]
    load_all_translations
    current = I18n.locale.to_s
    @id = locale
    others = @translations.keys.dup.delete_if {|local| local.length != 2 } - [current]
    puts "LOCS #{others.join('-')}"
    category_filter
    @translations.dup.each do | key , val |
      next unless key.starts_with? current
      other_key = key.sub( current , locale)
      if other_val = @translations[other_key]
        if other_val.text == val.text  #flag copied text
          other_val.text = "Same as default"
        else # all ok  so remove
          @translations.delete other_key
        end
      else # flag as completely missing
        @translations[other_key] = Translation.new( other_key , "" , "missing")
      end
    end
    prefix_filter locale 
    render :template => "translations/show"
  end
  def file
    @file = params[:id] 
    load_translation @file
    category_filter
    @id = @translations.first[0][0,2] #TODO assumes one root
  end
  
  def edit
    @key = params[:id]
    load_all_translations
    t = @translations[@key] 
    @text = t ? t.text : "MISSING" 
#    params[:value] ? params[:value] : I18n.t(params[ :id ]
  end
  def search
    show
    contains_filter params[:search]
    render "translations/show"
  end
  def show
    @id = params[:id]
    load_all_translations
    category_filter
    prefix_filter params["id"]
  end
  def create
    key = params[:id] 
    value = params[:value] 
    value = value.strip if value 
    load_all_translations
    unless key && value
      flash[:error] = "Internal error. Didn't find key #{key}"
      redirect_to params["return"] || "/index.html"
      return
    end
    unless trans = @translations[key]
        flash[:error] = "Internal error: File not found for key #{params[:id]}"
        redirect_to params["return"] || "/index.html"
        return
    end
    file = File.join(Rails.root , "config" , "locales" , trans.file)
    hash = YAML.load_file file
    if error = replace_key( hash , key , value)
      flash[:error] = error
      redirect_to params["return"] || "/index.html"
      return
    end
    content = hash.ya2yaml
    begin 
      YAML.load content
    rescue
      flash[:error] = "Could not save the value"
      redirect_to :action => 'edit' , :id => key , :value => value , :return => params[:return]
      return
    end    
    io = File.open( file , "w" )
    io << content
    io.close
    flash[:notice] = "Saved the key #{key}"
    redirect_to params["return"] || "/index.html"
  end

  protected

  def category_filter 
    @translations.delete_if { |key , val| val.class == Category }
  end
  def prefix_filter  prefixes
    prefixes = [prefixes] if prefixes.class == String 
    @translations.each_key do |key| 
      del = true
      prefixes.each do |prefix| # all this because of a bug(?!) in starts_with
        del = false if prefix == key[0 .. prefix.length-1]  
      end
      @translations.delete(key) if del
    end
  end
  def depth_filter max
    @translations.delete_if { |key,val| key.split(".").length > max }
  end
  def contains_filter word
    @translations.delete_if { |key,val| key.index(word) == nil }
  end
  def load_all_translations  
    @translations = {}
    all_files.each do |file|
     load_translation file 
    end
  end
  def load_translation file 
    hash =  YAML.load_file(File.join(Rails.root , "config" , "locales" , file))
    @translations = {} unless @translations
    hash.each do |root , these|
      add_children file , root , these
    end
  end
  def add_children file , root , these
    these.each do |sub , more |
      tag = "#{root}.#{sub}"
      if more.class == Hash
        add_children file , tag , more
        @translations[tag] = Category.new tag , file 
      else
        @translations[tag] = Translation.new tag , file , more
      end
    end
  end
  def all_files
    root = File.join(Rails.root , "config" , "locales")
    Dir.glob(File.join(root,"**" , "*.yml")).collect {|f| f.sub!("#{root}/","")}
  end
  
  def check_write key , value
    hasch = { key => value }
    file = StringIO.new
    file <<  hasch.ya2yaml
    file.rewind
    begin
      ho = YAML.load file
    rescue
      return false
    end
    return true
  end
  
  def replace_key hash , key , value
    keys = key.split "."
    last = keys.pop
    rep = hash
    keys.each do |k|
      rep = rep[ k ]
      return "No category #{rep} found" unless rep
      return "Category has text (but shouldn't): #{rep}" if rep.class == String
    end
    rep[last] = value
    return nil
  end
    
  def flatten_keys(hash , prefix )
    ret = []
    hash.each do |key, value|
      if value.class == String
        ret << "#{prefix}.#{key}"
        ##puts "#{prefix}.#{key}"
      else
        ret += flatten_keys( value , "#{prefix}.#{key}" ) if value
      end
    end
    ret
  end


end
