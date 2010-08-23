require "spec_helper"

describe Object do

  describe "blank?" do
    it "returns true for Objects perceived to be blank" do
      ["", false, nil, [], {}].each do |object|
        object.should be_blank
      end
    end

    it "returns false for every other Object" do
      ["!blank", true, [:a], {:a => "b"}].each do |object|
        object.should_not be_blank
      end
    end
  end

  describe "to_soap_value" do
    it "returns an xs:dateTime compliant String for Objects responding to to_datetime" do
      singleton = Object.new
      def singleton.to_datetime
        DateTime.new(2012, 03, 22, 16, 22, 33)
      end

      singleton.to_soap_value.should == "2012-03-22T16:22:33Z"
    end

    it "calls to_s unless the Object responds to to_datetime" do
      "value".to_soap_value.should == "value".to_s
    end
  end

  describe "to_soap_value!" do
    it "uses updated to_soap_value if overriden" do
      obj = Object.new
      def obj.to_soap_value; :special_value end

      obj.to_soap_value!.should == :special_value
    end
  end
end
