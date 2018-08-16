require "swaggerator/version"
require "swaggerator/extractors/params_extractor"
require "swaggerator/mockers/action_controller_simulator"
require "swaggerator/mockers/action_param_interceptor"
require "swaggerator/integrator"
require "swaggerator/helpers/routes_mapper.rb"
require "swaggerator/renderer"
require 'active_support/all'

module Swaggerator
  # Your code goes here...
    require 'railtie' if defined?(Rails)

end
