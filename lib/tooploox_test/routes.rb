module TooplooxTest

	class Routes < Array

	  def add(*args, &action)
	    self << Route.new(*args, &action)
	  end
		
		def match(verb, path)
			return nil if self.empty?
			routes = self.select { |route| route.verb == verb }
      paths  = routes.map {|route| route.path }

      path, values = TooplooxTest.engine.match(path, paths)
      return nil if path.nil?

      route = routes.detect {|route| route.path == path }
      route.values = values
      route			
		end

		class Route
		  attr_accessor :verb, :path, :action, :values

		  def initialize(verb, path, &action)
		    self.verb = verb
		    self.path = path
				self.action = action
				self.values = nil
		  end
		end
	
	end

end
