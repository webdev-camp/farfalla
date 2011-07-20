class TranslationsController < ApplicationController
  @@keys = {}
  
  def index
    @page =  "index"
  end

  def create
    key = params["key"] 
    value = params["value"] 
    value = value.strip if value 
    unless key && value
      flash[:error] = "Internal error. Didn't find key #{key}"
      redirect_to redirect_to params["return"] || "/index.html"
      return
    end
    unless file = get_file
      redirect_to redirect_to params["return"] || "/index.html"
      return
    end
    hash = YAML.load_file file
    replace_key hash["fi"] , key , value
    content = hash.ya2yaml
    begin 
      YAML.load content
    rescue
      flash[:error] = "Could not save the value"
      redirect_to :action => 'index' , :key => key , :value => value , :return => params[:return]
      return
    end    
    io = File.open( file , "w" )
    io << content
    io.close
    redirect_to params["return"] || "/index.html"
  end

  protected

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
      #puts "REP #{rep != nil}"
      #puts "K #{k}"
      rep = rep[ k ]
    end
    rep[last] = value
  end
  
  def get_file 
    key = params[:key]
    if @@keys.empty?
      Dir["#{Rails.root}/config/locales/*.yml"].each do |f|
        flatten_keys(YAML.load_file(f)["fi"] , "fi").each {|k| @@keys[k] = f } 
      end
    end
    k = @@keys["fi.#{key}"]
    return k if k
    ks = key.split(".")
    ks.pop
    key = "fi." + ks.join(".")
    @@keys.each do | k , v |
      #puts "HIT #{k}  to #{key}" if k.start_with? key
      return v if k.start_with? key
    end
    fash[:error] = "Internal error: File not found for key #{params[:key]}"
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
