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
			{:name=>:name, :description=>"Name", :type=>"string", },
			{:name=>:email, :description=>"Email", :type=>"string"}, 

			{:name=>:delivery_address, :description=>"Delivery address", type: "object", 
			properties:{ :address=>{ type: "string", :description=>"Address"},:street=> 
			{ type: "string", description: "Street"}} }
		]
		expect(klass.codify(params)).to eq response


	end

	#[:subscription_id, :delivery_address_id, :user_id, {:packages=>{:add=>[:id, :package_id, :eta, :package_name, :price, :is_addon, {:included_items=>[:id, :item_id, :item_name, :quantity, :price, :cgst, :sgst, :igst, {:included_skus=>[:id, :sku_id, :sku_name]}]}]}}]

end