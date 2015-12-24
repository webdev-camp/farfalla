require 'rails_helper'

RSpec.describe "resellers/edit", type: :view do
  before(:each) do
    @reseller = assign(:reseller, Reseller.create!(
      :name => "MyString",
      :address => "MyString",
      :city => "MyString",
      :link => "MyString"
    ))
  end

  it "renders the edit reseller form" do
    render

    assert_select "form[action=?][method=?]", reseller_path(@reseller), "post" do

      assert_select "input#reseller_name[name=?]", "reseller[name]"

      assert_select "input#reseller_address[name=?]", "reseller[address]"

      assert_select "input#reseller_city[name=?]", "reseller[city]"

      assert_select "input#reseller_link[name=?]", "reseller[link]"
    end
  end
end
