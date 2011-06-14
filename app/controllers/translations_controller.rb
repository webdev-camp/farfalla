class TranslationsController < ApplicationController
  layout :false
  @@keys = {}
  
  def index

  end

  def create
    key = params["key"] 
    value = params["value"] 
    unless key && value
      #puts "NO #{key} or value #{value}"
      redirect_to "/index.html"
      return
    end
    unless file = get_file
      redirect_to "/index.html"
      #puts "NO key found for #{key}"
      return
    end
    #puts "File #{file}"
    hash = YAML.load_file file
    replace_key hash["fi"] , key , value
    io = File.open( file , "w" )
    io << hash.ya2yaml
    io.close
    if params["return"]
      redirect_to params["return"]
    else
      redirect_to "/index.html"
    end
  end

  protected
  
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
