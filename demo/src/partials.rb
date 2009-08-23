module Sinatra
  module Partials
    def sayhi
      "Hello Sinatra"
    end
    def partial(template, *args)
      options = {:layout => false}
      options.merge!(args.pop) if args.last.is_a?(::Hash) 
      erb(template, options)
    end
  end
end