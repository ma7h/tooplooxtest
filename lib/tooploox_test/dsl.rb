module TooplooxTest
	
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

end