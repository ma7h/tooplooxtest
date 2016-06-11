module TooplooxTest
  module Engine #:nodoc:

    def self.match(*args)
      Base.match(*args)
    end

    class Base
      def self.match(path, routes)
        path     = Path.new(path)
        patterns = routes.map {|route| Pattern.new(Array(route).first) }
				
        patterns.each do |pattern|
          return [pattern.to_s, pattern.vars] if pattern == path
        end

        [nil, []]
      end
    end

    class Path #:nodoc:
      attr_accessor :parts, :ext

      def initialize(path)
        self.parts, self.ext = split_path(path)
      end

      def to_s
        '/' + self.parts.join('/') + self.ext
      end

      private
        def split_path(path)
          path  = path.to_s
          ext   = Pathname(path).extname
          path  = path.sub(/#{ext}$/,'')
          parts = path.split('/').reject {|part| part.empty? }
          [parts, ext]
        end
    end

    class Pattern < Path #:nodoc:

      def variables
        return [] unless @match
				
        a = []
        self.parts.each_with_index do |part,i|
          a << @match.parts[i] if part[0] == ?:
        end
        a << @match.ext[1..-1] if self.ext[1] == ?:
        a
      end
      alias :vars :variables

      def ==(path)
        is_match = size_match?(path) && ext_match?(path) && static_match?(path)
        @match = path if is_match
        is_match
      end

      private
        def size_match?(path)
          self.parts.size == path.parts.size
        end

        def ext_match?(path)
          (self.ext == path.ext) || (self.ext[1] == ?: && !path.ext.empty?)
        end

        def static_match?(path)
          self.parts.each_with_index do |part,i|
            return false unless part[0] == ?: || path.parts[i] == part
          end
          true
        end
    end
  end
end
