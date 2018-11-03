require "selenium-webdriver"

require_relative "kakuyomu_client/version"

class KakuyomuClient
  Error            = Class.new(StandardError)

  BASE_URL = 'https://kakuyomu.jp'

  attr_reader :base_url, :driver

  def initialize(base_url: BASE_URL, driver: Selenium::WebDriver.for(:chrome))
    @base_url  = base_url
    @driver    = driver
    @logged_in = false
  end

  def logged_in?
    @logged_in
  end

  def login!(email:, password:)
    driver.navigate.to("#{base_url}/login")
    driver.find_element(name: 'email_address').send_keys(email)
    driver.find_element(name: 'password').send_keys(password)
    driver.find_element(xpath: '//button[text()="ログイン"]').click

    Selenium::WebDriver::Wait.new.until do
      driver.find_element(id: 'page-my')
    end

    @logged_in = true
  rescue Selenium::WebDriver::Error::WebDriverError => e
    raise Error, 'Logging in failed: ', e.message
  end
end
