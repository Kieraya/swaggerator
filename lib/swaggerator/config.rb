module Swaggerator 

	class Config
		@@title= "Sample API"
		@@description  ="Sample API description"
		@@open_api= "3.0.0"
		@@version = "1.2.0"
		def self.open_api_version(data=nil)
			@@open_api = data if data
			return @@open_api
		end

		def self.title(data=nil)
			@@title = data if data
			return @@title
		end

		def self.description(data=nil)
			@@description = data if data
			return @@description
		end
		def self.version(data=nil)
			@@version = data if data
			return @@version
		end
		
		def self.configure(&block)
			
			self.class_eval(&block) if block_given?

		end
	end
end