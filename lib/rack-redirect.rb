module CollegeRecruitU
  class RackRedirect
    def initialize(app, &block)
      @app = app
      yield self if block_given?
    end

    def call(env)
      server = env['SERVER_NAME']
      if server =~ /^www\.collegerecruitu\.com$/
        @app.call(env)
      else
        [302, {'Location' => 'https://www.collegerecruitu.com/'}, ['Redirecting to https://www.collegerecruitu.com/']]
      end
    end
  end
end
