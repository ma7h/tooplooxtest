#first Rack test.
require 'bundler'
Bundler.require

class Route
  attr_accessor :verb,:path, :action

  def initialize(verb, path, &action)
    self.verb = verb
    self.path = path
		self.action = action
  end
end

class App
	
	def call(env)
		request = Rack::Request.new(env)
		verb = request.request_method.downcase.to_sym
		path = Rack::Utils.unescape(request.path_info)
		route = Route.new(verb, path) do |params|
	    <<-html
	    <pre>
	      params: #{params.inspect}
	    </pre>
	    html
		end
		route.nil? ?
			[404, {'Content-Type' => 'text/html'}, ['404 page not found']] :
			[200, {'Content-Type' => 'text/html'}, [route.action.call(request.params)]] 
	end

end

run App.new