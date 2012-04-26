require "spec_helper"

describe CustomDataController do
  describe "routing" do

    it "routes to #index" do
      get("/custom_data").should route_to("custom_data#index")
    end

    it "routes to #new" do
      get("/custom_data/new").should route_to("custom_data#new")
    end

    it "routes to #show" do
      get("/custom_data/1").should route_to("custom_data#show", :id => "1")
    end

    it "routes to #edit" do
      get("/custom_data/1/edit").should route_to("custom_data#edit", :id => "1")
    end

    it "routes to #create" do
      post("/custom_data").should route_to("custom_data#create")
    end

    it "routes to #update" do
      put("/custom_data/1").should route_to("custom_data#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/custom_data/1").should route_to("custom_data#destroy", :id => "1")
    end

  end
end
