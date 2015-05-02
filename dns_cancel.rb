#DNS reverse lookup cancel

class Rack::Handler::WEBrick
	class << self
		alias_method :run_original, :run
	end
	def self.run(app, options={})
		options[:DoNotReverseLookup] = true
		run_original(app, options)
	end
end 