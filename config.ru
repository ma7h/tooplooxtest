#first Rack test.
require 'bundler'
Bundler.require

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require "tooploox_test"

class App
	include TooplooxTest::DSL
	
	get ("/") do |params|
    <<-html
    <pre>
      params: #{params.inspect}
    </pre>
    html
	end
	
	get ("/test") do |params|
    <<-html
    <pre>
		test
      params: #{params.inspect}
    </pre>
    html
	end
	
	def call(env)
		request = Rack::Request.new(env)
		verb = request.request_method.downcase.to_sym
		path = Rack::Utils.unescape(request.path_info)
		
		route = self.class.routes.select { |route| route.verb == verb && route.path == path }.first
		route.nil? ?
			[404, {'Content-Type' => 'text/html'}, ['404 page not found']] :
			[200, {'Content-Type' => 'text/html'}, [route.action.call(request.params)]] 
	end

end

run App.new