class KakuyomuAgent
  module Actions
    class CreateEpisode < Action
      def run(work_id, title, body, date = nil)
        driver.get(new_episode_url(work_id))

        title_input = driver.find_element(name: 'title')
        title_input.clear
        title_input.send_keys(title)

        driver.find_element(name: 'body').send_keys(body)

        driver.find_element(id: 'reserveButton').click

        episode_id = if date.nil? || date < Time.now
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
        driver.find_element(id: 'reservationControl-footer').find_element(tag_name: 'button').click

        Selenium::WebDriver::Wait.new.until do
          driver.find_element(id: 'page-my-works-episodes-published')
        end

        UrlHelper.extract_episode_id(driver.current_url)
      end

      def reserve(date)
        driver.find_element(id: 'reservationInput-reserved').click
        driver.find_element(name: 'reservation_date').tap do |date_input|
          date_input.clear
          date_input.send_keys(date.strftime('%F'))
        end
        driver.find_element(name: 'reservation_time').tap do |time_input|
          time_input.clear
          time_input.send_keys(date.strftime('%R'))
        end
        driver.find_element(id: 'reservationControl-footer').find_element(tag_name: 'button').click

        Selenium::WebDriver::Wait.new.until do
          driver.find_element(id: 'modelessMessage')
        end

        edit_episode_url = driver.find_element(xpath: "//span[@class='widget-myWork-episode-labelDate' and contains(text(), '#{date.strftime('%Y年%-m月%-d日 %R')}')]/following::a[text()='編集']")['href']
        UrlHelper.extract_episode_id(edit_episode_url)
      end
    end
  end
end
