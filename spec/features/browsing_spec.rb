require 'spec_helper'

describe PageController  do
  it "shows root" do
    visit_path root_path
  end
end
