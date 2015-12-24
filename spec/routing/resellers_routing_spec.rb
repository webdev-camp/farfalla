require "rails_helper"

RSpec.describe ResellersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/resellers").to route_to("resellers#index")
    end

    it "routes to #new" do
      expect(:get => "/resellers/new").to route_to("resellers#new")
    end

    it "routes to #show" do
      expect(:get => "/resellers/1").to route_to("resellers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/resellers/1/edit").to route_to("resellers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/resellers").to route_to("resellers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/resellers/1").to route_to("resellers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/resellers/1").to route_to("resellers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/resellers/1").to route_to("resellers#destroy", :id => "1")
    end

  end
end
