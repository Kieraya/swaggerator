RSpec.describe Swaggerator::Helpers::RoutesMapper do
  it "maps over routes correctly" do
  	routes = {
  		"/api/v1/users":
  			{
  				"post": 
  				{
  					name: "users#post"
  				}, 
  				"get":
  				{
  					name: "users#get"
  				}
  			},
  		"/api/v1/cars":
  			{
  				"post": 
  				{
  					name: "cars#post"
  				}, 
  				"get":
  				{
  					name: "cars#get"
  				}
  			}
  	}

  	detected_methods= []
  	actual_methods = ["users#post", "users#get", "cars#post", "cars#get"]
  	Swaggerator::Helpers::RoutesMapper.map(routes) do |route| 
  		detected_methods<<route[:name]
  	end
  	expect(detected_methods).to eq(actual_methods)

  end

 
end
