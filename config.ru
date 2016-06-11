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
			Hello World!
      params: #{params.inspect}
    </pre>
    html
	end
	
	get ("/:file.:ext") do |file, ext, params|
    <<-html
    <pre>
      file: #{file.inspect}
      ext: #{ext.inspect}
      params: #{params.inspect}
    </pre>
    html
	end
	
	get ("/date/:d/:m/:y") do |d, m, y, params|
    <<-html
    <pre>
			DATE
			Day: #{d.inspect}
			Month: #{m.inspect}
			Year: #{y.inspect}
	    params: #{params.inspect}
    </pre>
    html
	end
	
	def call(env)
		request = Rack::Request.new(env)
		verb = request.request_method.downcase.to_sym
		path = Rack::Utils.unescape(request.path_info)
		
    route = self.class.routes.match(verb, path)
    route.nil? ?
      [404, {'Content-Type' => 'text/html'}, ['404 page not found']] :
      [200, {'Content-Type' => 'text/html'}, [route.action.call(*route.values.push(request.params))]]
	end

end

run App.new