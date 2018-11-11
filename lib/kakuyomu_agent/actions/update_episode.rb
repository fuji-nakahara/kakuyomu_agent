class KakuyomuAgent
  module Actions
    class UpdateEpisode < Action
      def run(work_id, episode_id, title, body)
        driver.get(edit_episode_url(work_id, episode_id))

        title_input = driver.find_element(name: 'title')
        title_input.clear
        title_input.send_keys(title)

        body_textarea = driver.find_element(name: 'body')
        body_textarea.clear
        body_textarea.send_keys(body)

        driver.find_element(id: 'updateButton').click

        Selenium::WebDriver::Wait.new.until do
          driver.find_element(id: 'page-my-works-episodes-published')
        end

        episode_url(work_id, episode_id)
      rescue Selenium::WebDriver::Error::WebDriverError => e
        raise ActionFailedError.new(e)
      end
    end
  end
end
