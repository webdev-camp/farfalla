require 'rails_helper'

RSpec.describe "resellers/new", type: :view do
  before(:each) do
    assign(:reseller, Reseller.new(
      :name => "MyString",
      :address => "MyString",
      :city => "MyString",
      :link => "MyString"
    ))
  end

  it "renders new reseller form" do
    render

    assert_select "form[action=?][method=?]", resellers_path, "post" do

      assert_select "input#reseller_name[name=?]", "reseller[name]"

      assert_select "input#reseller_address[name=?]", "reseller[address]"

      assert_select "input#reseller_city[name=?]", "reseller[city]"

      assert_select "input#reseller_link[name=?]", "reseller[link]"
    end
  end
end
