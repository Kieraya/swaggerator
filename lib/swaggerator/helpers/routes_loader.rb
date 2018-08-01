module Swaggerator
	module Helpers
		class RoutesLoader
			def self.get_inspector
				begin
				  require 'rails/application/route_inspector'
				  return Rails::Application::RouteInspector.new
				rescue LoadError
				  require 'action_dispatch/routing/inspector'
				  return ActionDispatch::Routing::RoutesInspector.new([])
				end
			end
			## Collects routes for the rails routers
			def self.get_routes
				Rails.application.reload_routes!
			    return Rails.application.routes.routes
			end
			def self.extract_routes
				routes = get_inspector.send :collect_routes, get_routes
				routes.reject!{ |r| r[:verb].blank?} #Reject if the route is an engine. 
				routes
			end
		end
	end
end
