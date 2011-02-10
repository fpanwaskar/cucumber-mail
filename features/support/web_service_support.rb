module WebServiceSupport
  class WebService
    def initialize(host_and_port)
      @host_and_port = host_and_port
    end
    
    def get(path)
      response = JSON.parse(RestClient.get(url(path)))
      check_for_errors_in(response)
      response
    end
    
    def post(path, params)
      response = JSON.parse(RestClient.post(url(path), params))
      check_for_errors_in(response)
      response
    end

  private
    
    def url(path)
      "http://#{@host_and_port}/#{path}"
    end
    
    def check_for_errors_in(response)
      if response['status'] == 'error'
        raise "Response failed: #{response.inspect}"
      end
    end
  end
  
  def web_service
    @web_service ||= WebService.new('10.63.36.213:8081')
  end
end

World(WebServiceSupport)
