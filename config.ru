#first Rack test.
require 'bundler'
Bundler.require

class App

	def call(env)
		request = Rack::Request.new(env)
		path = Rack::Utils.unescape(request.path_info)
		path == "/" ?	[200, {'Content-Type' => 'text/html'}, ['Tooploox test']] :	[404, {'Content-Type' => 'text/html'}, ['404 page not found']]
	end
	
	
end

run App.new