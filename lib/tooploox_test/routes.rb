# Tooploox Test Module
module TooplooxTest
  # Routes
  class Routes < Array
    def add(*args, &action)
      self << Route.new(*args, &action)
    end

    def match(verb, path)
      return nil if empty?
      routes = select { |r| r.verb == verb }
      paths  = routes.map(&:path)

      path, values = TooplooxTest.engine.match(path, paths)
      return nil if path.nil?

      route = routes.detect { |r| r.path == path }
      route.values = values
      route
    end
    # Route
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
