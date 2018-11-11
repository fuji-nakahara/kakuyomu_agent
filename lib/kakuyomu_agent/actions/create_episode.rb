class KakuyomuAgent
  module Actions
    class CreateEpisode < Action
      def run(work_id, title, body)
        driver.get(new_episode_url(work_id))

        title_input = driver.find_element(name: 'title')
        title_input.clear
        title_input.send_keys(title)

        driver.find_element(name: 'body').send_keys(body)

        driver.find_element(id: 'reserveButton').click
        driver.find_element(id: 'reservationControl-footer').find_element(tag_name: 'button').click

        Selenium::WebDriver::Wait.new.until do
          driver.find_element(id: 'page-my-works-episodes-published')
        end

        episode_id = UrlHelper.extract_episode_id(driver.current_url)
        episode_url(work_id, episode_id)
      rescue Selenium::WebDriver::Error::WebDriverError => e
        raise ActionFailedError.new(e)
      end
    end
  end
end
