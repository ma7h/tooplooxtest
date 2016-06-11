#first Rack test.
require 'bundler'
Bundler.require

module TooplooxRouter
	
  module DSL
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        @routes = Routes.new
      end
    end

    module ClassMethods
      attr_reader :routes

      def get(path, &block)
				routes.add(:get, path, &block)
			end
    end
  end

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

class App
	include TooplooxRouter::DSL
	
	get ("/") do |params|
    <<-html
    <pre>
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