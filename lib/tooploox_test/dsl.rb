module TooplooxTest
  module DSL #:nodoc:
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        @routes = Routes.new
      end
    end

    module ClassMethods #:nodoc:
      attr_reader :routes

      def get(path, &block)
        routes.add(:get, path, &block)
      end

      def post(path, &block)
        routes.add(:post, path, &block)
      end

      def put(path, &block)
        routes.add(:put, path, &block)
      end

      def delete(path, &block)
        routes.add(:delete, path, &block)
      end
    end
  end
end
