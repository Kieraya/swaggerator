class Swaggerator::Helpers::DefinitionCleaner
	CLEANABLES = [:reqs, :regexp, :executioner, :source_code, :controller_class]
	def self.clean(routes)
		routes.map do |route|
			CLEANABLES.each do |cleanable|
				route.delete(cleanable)
			end		
			
	
		end
		routes
	end
end