require 'spec_helper'

describe PageController  do
  before :all do
    @pages = {}
  end
  
  def walks url 
    return if url.include? "http"
    visit url
    puts "Walking #{url}"
    page.all("a").each do |p|
      ref = p[:href]
      next if @pages.has_key? ref
      @pages[ref] = false
      walks ref
    end
  end

  it "renders ok" do 
    walks "/"
  end

end
