class TranslationsController < ApplicationController
  layout :false
  @@keys = {}
  
  def index

  end

  def create
    key = params["key"] 
    value = params["value"] 
    file = get_file
    unless key && value && file
      redirect_to "/index.html"
      puts "NO #{key} #{@@keys.keys.join(' ')}"
      return
    end
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
      rep = rep[ k ]
    end
    rep[last] = value
  end
  
  def get_file
    if @@keys.empty?
      Dir["#{Rails.root}/config/locales/*.yml"].each do |f|
        flatten_keys(YAML.load_file(f)["fi"] , "fi").each {|key| @@keys[key] = f } 
      end
    end
    @@keys["fi.#{params[:key]}"]
  end
  
  def flatten_keys(hash , prefix )
    ret = []
    hash.each do |key, value|
      if value.class == String
        ret << "#{prefix}.#{key}"
        puts "#{prefix}.#{key}"
      else
        ret += flatten_keys( value , "#{prefix}.#{key}" ) if value
      end
    end
    ret
  end


end
