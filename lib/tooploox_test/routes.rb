module TooplooxTest

	class Routes < Array

	  def add(*args, &action)
	    self << Route.new(*args, &action)
	  end

		class Route
		  attr_accessor :verb,:path, :action

		  def initialize(verb, path, &action)
		    self.verb = verb
		    self.path = path
				self.action = action
		  end
		end
	
	end

end #TooplooxRouter
