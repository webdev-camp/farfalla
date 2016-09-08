require 'rails_helper'

RSpec.describe Reseller, type: :model do

  it "factory is ok" do
    res = build :reseller
    expect(res.save).to be true
  end

end
