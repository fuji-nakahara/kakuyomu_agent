class KakuyomuClient
  module UrlUtils
    class << self
      def extract_work_id(url)
        url[%r{works/(\d+)}, 1]
      end

      def extract_episode_id(url)
        url[%r{episodes/(\d+)}, 1]
      end
    end
  end
end
