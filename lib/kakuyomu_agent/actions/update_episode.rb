class KakuyomuAgent
  module Actions
    class UpdateEpisode < Action
      def run(work_id, episode_id, title, body, date = nil)
        driver.get(edit_episode_url(work_id, episode_id))

        driver.find_element(name: 'title').tap do |title_input|
          title_input.clear
          title_input.send_keys(title)
        end
        driver.find_element(name: 'body').tap do |body_textarea|
          body_textarea.clear
          body_textarea.send_keys(body)
        end

        if date.nil? || date < Time.now
          publish
        else
          reserve(date)
        end

        episode_url(work_id, episode_id)
      rescue Selenium::WebDriver::Error::WebDriverError => e
        raise ActionFailedError.new(e)
      end

      private

      def publish
        driver.find_element(id: 'updateButton').click

        wait.until do
          driver.find_element(id: 'page-my-works-episodes-published')
        end
      end

      def reserve(date)
        driver.find_element(id: 'reserveButton').click
        driver.find_element(name: 'reservation_date').tap do |date_input|
          date_input.clear
          date_input.send_keys(date.strftime('%F'))
        end
        driver.find_element(name: 'reservation_time').tap do |time_input|
          time_input.clear
          time_input.send_keys(date.strftime('%R'))
        end
        driver.find_element(id: 'reservationControl-footer').find_element(tag_name: 'button').click

        wait.until do
          driver.find_element(id: 'modelessMessage')
        end
      end
    end
  end
end
