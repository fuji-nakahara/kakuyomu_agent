class KakuyomuAgent
  module Actions
    class DeleteEpisode < Action
      def run(work_id, episode_id)
        driver.get(edit_episode_url(work_id, episode_id))

        driver.find_element(id: 'contentMainHeader-toolButton').click
        sleep 1
        driver.find_element(id: 'contentAsideHeader').find_element(xpath: '//*[contains(text(), "ツール")]').click
        sleep 1
        driver.find_element(id: 'deleteEpisode').find_element(tag_name: 'button').click
        driver.switch_to.alert.accept

        wait.until do
          driver.find_element(id: 'modelessMessage')
        end

        true
      rescue Selenium::WebDriver::Error::WebDriverError => e
        raise ActionFailedError.new(e)
      end
    end
  end
end
