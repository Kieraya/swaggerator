RSpec.describe Swaggerator::Extractors::ParamsExtractor do
	klass =Swaggerator::Extractors::ParamsExtractor

	it "should detect direct param fields" do

		source_code= %q{
			def create
				u = User.new({id: params[:id], name: params[:name], identifier: params[:name]} )
				u.address(params[:address])

			end
		}

		ext = klass.new(source_code)
		expect(ext.param_fields).to eq([:id, :name, :address])
	end

	it "should detect just one param method calls" do

		source_code= %q{
			def create
				u = User.new({id: user_params[:id], name: user_params[:name], identifier: user_param[:name]} )
				u.address(user_params[:address])

			end
		}
		parameter_method_names = ["user_params"]
		ext = klass.new(source_code)
		##puts expect(ext.parameters_detected.keys).to eq(parameter_method_names)
		#ext.parameters_detected.to e
	end
	it "should detect multiple param method calls" do

		source_code= %q{
			def create
				params[:id]
				u = User.new({id: user_params[:id], name: user_params[:name], identifier: user_param[:name]} )
				u.address(user_params[:address])
				Address.create(user_address_params)

			end
		}
		parameter_method_names = ["user_params","user_address_params"]
		ext = klass.new(source_code)
		expect(ext.parameters_detected.keys).to eq(parameter_method_names)
		#ext.parameters_detected.to e
	end
	it "should detect multiple param method calls" do

		source_code= %q{
			def create
				u = User.new({id: user_params[:id], name: user_params[:name], identifier: user_param[:name]} )
				u.address(user_params[:address])
				Address.create(user_address_params)

			end
		}
		parameter_method_names = ["user_params","user_address_params"]
		ext = klass.new(source_code)
		expect(ext.parameters_detected.keys).to eq(parameter_method_names)
	end
	it "should detect nested param fields" do

		source_code= %q{
			def create
				u = User.new({id: params[:user_identification][:something], name: params[:name], identifier: params[:name]} )
				u.address(params[:address])

			end
		}

		ext = klass.new(source_code)
		expect(ext.param_fields).to eq([{:user_identification=>:something}, :name, :address])
	end

end