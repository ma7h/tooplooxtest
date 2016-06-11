module TooplooxTest
	class << self
    attr_accessor :engine
   def engine() @engine || Engine end
  end
	
   autoload :DSL,    'tooploox_test/dsl'
   autoload :Routes, 'tooploox_test/routes'
   autoload :Engine, 'tooploox_test/engine'
	 
end
