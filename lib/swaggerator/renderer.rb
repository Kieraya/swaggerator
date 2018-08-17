module Swaggerator
	class Renderer
		def self.render(routes_grouped)
			response = { paths: {},
				openapi: Swaggerator::Config.open_api_version,
				info: {title: Swaggerator::Config.title,
				description: Swaggerator::Config.description,
				version: Swaggerator::Config.version}, 
			}
	 
		  	routes_grouped.each do |path, path_content|
	  			path_response={}
	  		    path_content.each do |method_name, method_content|
	  				method_response= {}
					method_response[:responses] = {}
  					method_response[:responses]['200']= {description: "Stubbed"}

          			method_response[:parameters]= []
          			method_response[:tags]= method_content[:tags]

          			method_content[:route_params].each do | route_param|
	          			param_response={
	  						in: :path,
	  						name: route_param,
	  						required: true,
	  						description: route_param.humanize,
	  						schema: {type: "string"}

	  					}

	  					method_response[:parameters] << param_response

          			end #routeparams.each
          			method_content[:body_params].map do |body_param|

          				method_response[:requestBody]= method_response[:requestBody] || {content: {"application/json"=>{"schema"=>{type: "object", :properties=>{}}}}} 

          				method_response[:requestBody][:content]["application/json"]["schema"][:properties][body_param[:name]] = body_param.except(:name)

          			end if method_content[:body_params] && method_name.to_sym!= :delete
          			method_content[:query_params].map do |param|
          				param[:in] = "query"
          				param[:schema] = {type: param[:type]}

          				method_response[:parameters] << param.except(:type)
          			end if method_content[:query_params]


          			path_response[method_name]= method_response

	  		    end #path_content.each

	  		    response[:paths][path]= path_response

		  	end#routes_grouped.each
			return response

		end#render
	end#class Renderer
end#module Swaggerator