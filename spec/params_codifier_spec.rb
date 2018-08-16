require "swaggerator/helpers/params_codifier"

RSpec.describe Swaggerator::Helpers::ParamsCodifier do
	klass =Swaggerator::Helpers::ParamsCodifier

	it "should codify simple params" do 
		params= [:name, :email, :phone_number]
		response = [{:name=>:name, :description=>"Name", :type=>"string"},{:name=>:email, :description=>"Email", :type=>"string"}, {:name=>:phone_number, :description=>"Phone number", :type=>"string"}]
		expect(klass.codify(params)).to eq response
	end

	it "should codify nested params" do 
		params= [:name, :email, :delivery_address=>[:address,:street]]
		response = [
			{:name=>:name, :description=>"Name", :type=>"string", },{:name=>:email, :description=>"Email", :type=>"string"}, 

			{:name=>:delivery_address, :description=>"Delivery address", type: "object", properties:[ {name: :address, type: "string", :description=>"Address"}, {name: :street, type: "string", description: "Street"}] }
		]
		#puts klass.codify(params)
		expect(klass.codify(params)).to eq response


	end
	it "should codify double nested params" do 
		params= [:name,:delivery_address=>[:address=>[:street, :block]]]
		response = [
			{:name=>:name, :description=>"Name", :type=>"string", }, 

			{:name=>:delivery_address, :description=>"Delivery address", type: "object", properties:[ {name: :address, type: "object", :description=>"Address", properties: [{:name=> :street, description: "Street", type: "string"},{:name=> :block, description: "Block", type: "string"}]}] }
		]
		#puts klass.codify(params)
		expect(klass.codify(params)).to eq response


	end
end