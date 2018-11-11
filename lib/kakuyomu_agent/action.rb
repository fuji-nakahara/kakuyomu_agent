class KakuyomuAgent
  class Action
    include UrlHelper
    extend Forwardable

    def_delegators :@agent, :base_url, :driver

    def initialize(agent)
      @agent = agent
    end

    def run
      raise NotImplementedError
    end
  end
end
