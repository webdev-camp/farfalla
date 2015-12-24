require 'rails_helper'

RSpec.describe "resellers/show", type: :view do
  before(:each) do
    @reseller = assign(:reseller, Reseller.create!(
      :name => "Name",
      :address => "Address",
      :city => "City",
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Link/)
  end
end
