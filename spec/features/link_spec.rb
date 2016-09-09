require 'spec_helper'

describe "Links"  do
  before :all do
    @agent = Mechanize.new
  end

  def link_targets
    targets = []
    Dir.glob("config/locales/*.yml").each do |filepath|
      locale_file = I18nSpec::LocaleFile.new(filepath)
      locale_file.flattened_translations.each do |key , value|
        targets << value if key.include? ".link"
      end
    end
    targets
  end

  it "has correct links" do
    server_link = I18n.t('product_link.server')
    link_targets.each do |a|
      next if a.blank? or a == "Linkki"
      link = server_link + a
      page = @agent.get link
      sleep 1
      expect( page.at( "#add-to-cart-button") ).not_to be nil
    end

  end

end
