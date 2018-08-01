require "swaggerator/extractors/params_method_parser"
RSpec.describe Swaggerator::Extractors::ParamsMethodParser do
  
  it "detects primitive permitted parameters correctly" do

  	source_code = %q{
  		params.permit(:name, :user_id)
  	}
  	extractor = Swaggerator::Extractors::ParamsMethodParser.new(source_code)
  	#puts extractor.inspect
  	#expect(extactor.callstack).to.be(Array)
  	expect(extractor.params).to eq([:name, :user_id])
  end 
  it "detects complex permitted parameters correctly" do

  	source_code = %q{
  		params.permit(:name, :user_id, :cars=>[:name, :id, {:wheels=>[:wheel, :wheel_pos]}] )
  	}
  	extractor = Swaggerator::Extractors::ParamsMethodParser.new(source_code)
  	#puts extractor.inspect
  	#expect(extactor.callstack).to.be(Array)
  	expect(extractor.params).to eq([:name, :user_id, {:cars=>[:name, :id, {:wheels=>[:wheel, :wheel_pos]}]} ])
  end 

   it "detects simple parameters passed as array correctly" do

  	source_code = %q{
  		params.permit([:name, :user_id])
  	}
  	extractor = Swaggerator::Extractors::ParamsMethodParser.new(source_code)
  	#puts extractor.inspect
  	#expect(extactor.callstack).to.be(Array)
  	expect(extractor.params).to eq([:name, :user_id])
  end 

  it "detects complex permitted parameters passed as array correctly" do

  	source_code = %q{
  		params.permit([:name, :user_id, {:cars=>[:name, :id, {:wheels=>[:wheel, :wheel_pos]}]} ] )
  	}
  	extractor = Swaggerator::Extractors::ParamsMethodParser.new(source_code)
  	#puts extractor.inspect
  	#expect(extactor.callstack).to.be(Array)
  	expect(extractor.params).to eq([:name, :user_id, {:cars=>[:name, :id, {:wheels=>[:wheel, :wheel_pos]}]} ])
  end 

  it "detects single required parameter(assume primitive)" do

  	source_code = %q{
  		params.require(:user)
  	}
  	extractor = Swaggerator::Extractors::ParamsMethodParser.new(source_code)
  	#puts extractor.inspect
  	#expect(extactor.callstack).to.be(Array)
  	expect(extractor.params).to eq([:user])
  end 

end


