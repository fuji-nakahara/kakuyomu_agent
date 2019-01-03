class KakuyomuAgent
  class Action
    include UrlHelper
    extend Forwardable

    def_delegators :@agent, :base_url, :driver

    attr_reader :wait

    def initialize(agent, wait: Selenium::WebDriver::Wait.new)
      @agent = agent
      @wait = wait
    end

    def run
      raise NotImplementedError
    end
  end
end
