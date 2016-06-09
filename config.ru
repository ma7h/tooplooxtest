#first Rack test.
require 'bundler'
Bundler.require

app = proc do |env|
  [ 200, {'Content-Type' => 'text/plain'}, ["Tooploox test"] ]
end

run app