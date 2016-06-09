#first Rack test.
require 'bundler'
Bundler.require

app = proc do |env|
  path = env["PATH_INFO"]
	if path == "/"
		[200, {'Content-Type' => 'text/html'}, ['Tooploox test']]
	else
		[404, {'Content-Type' => 'text/html'}, ['404 page not found']]
	end
end

run app