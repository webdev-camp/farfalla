require 'rails_helper'

RSpec.describe "resellers/index", type: :view do
  before(:each) do
    assign(:resellers, [
      Reseller.create!(
        :name => "Name",
        :address => "Address",
        :city => "City",
        :link => "Link"
      ),
      Reseller.create!(
        :name => "Name",
        :address => "Address",
        :city => "City",
        :link => "Link"
      )
    ])
  end

  it "renders a list of resellers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
