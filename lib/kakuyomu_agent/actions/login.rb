class KakuyomuAgent
  module Actions
    class Login < Action
      def run(email, password)
        driver.get(login_url)

        driver.find_element(name: 'email_address').send_keys(email)
        driver.find_element(name: 'password').send_keys(password)

        driver.find_element(xpath: '//button[text()="ログイン"]').click

        wait.until do
          driver.find_element(id: 'page-my')
        end
      rescue Selenium::WebDriver::Error::WebDriverError => e
        raise ActionFailedError.new(e)
      end
    end
  end
end
