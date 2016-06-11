module TooplooxTest
  class << self
    def engine
			Engine
		end
  end

  autoload :DSL,    'tooploox_test/dsl'
  autoload :Routes, 'tooploox_test/routes'
  autoload :Engine, 'tooploox_test/engine'
end
