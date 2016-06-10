#first Rack test.
require 'bundler'
Bundler.require

class Route
  attr_accessor :verb,:path

  def initialize(verb, path)
    self.verb = verb
    self.path = path
  end
end

class App
	
	def call(env)
		request = Rack::Request.new(env)
		verb = request.request_method.downcase.to_sym
		path = Rack::Utils.unescape(request.path_info)
		route = Route.new(verb, path)
		!route.nil? ? [200, {'Content-Type' => 'text/html'}, ['Tooploox test']] : [404, {'Content-Type' => 'text/html'}, ['404 page not found']]
	end

end

run App.new