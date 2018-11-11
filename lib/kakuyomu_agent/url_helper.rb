class KakuyomuAgent
  module UrlHelper
    class << self
      def extract_work_id(url)
        url[%r{works/(\d+)}, 1]
      end

      def extract_episode_id(url)
        url[%r{episodes/(\d+)}, 1]
      end
    end

    private

    def login_url
      "#{base_url}/login"
    end

    def episode_url(work_id, episode_id)
      "#{base_url}/works/#{work_id}/episodes/#{episode_id}"
    end

    def new_episode_url(work_id)
      "#{base_url}/my/works/#{work_id}/episodes/new"
    end

    def edit_episode_url(work_id, episode_id)
      "#{base_url}/my/works/#{work_id}/episodes/#{episode_id}"
    end
  end
end
