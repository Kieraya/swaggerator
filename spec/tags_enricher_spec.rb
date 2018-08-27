require "swaggerator/enrichers/tags_enricher"

RSpec.describe Swaggerator::Enrichers::TagsEnricher do
	klass =Swaggerator::Enrichers::TagsEnricher

	it "should tag apis properly " do 

		routes = [
			{
				path: "/users/:id",


			},
			{
				path: "/cars",
			},
			{
				path: "/users",
			},{
				path: "/users/:id/cars"
			},
			{
				path:"/api/v1/users/:id"
			}
		]

			routes_response = [
			{
				path: "/users/:id",
				tags: ["user"]

			},
			{
				path: "/cars",
				tags: ["car"]
			},
			{
				path: "/users",
				tags: ["user"]

			},{
				path: "/users/:id/cars",
				tags: ["user"]

			},{
				path:"/api/v1/users/:id",
				tags: ["user"]

			}

		]
		expect(klass.enrich(routes)).to eq(routes_response)
	end

end