require "selenium-webdriver"

require_relative "kakuyomu_client/url_utils"
require_relative "kakuyomu_client/version"

class KakuyomuClient
  Error            = Class.new(StandardError)
  NotLoggedInError = Class.new(Error)

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
    driver.navigate.to(login_url)
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

  def create_episode(work_id:, title:, body:)
    raise NotLoggedInError unless logged_in?

    driver.navigate.to(new_episode_url(work_id))
    driver.find_element(name: 'title').send_keys(title)
    driver.find_element(name: 'body').send_keys(body)
    driver.find_element(id: 'reserveButton').click
    driver.find_element(id: 'reservationControl-footer').find_element(tag_name: 'button').click

    Selenium::WebDriver::Wait.new.until do
      driver.find_element(id: 'page-my-works-episodes-published')
    end

    UrlUtils.extract_episode_id(driver.current_url)
  rescue Selenium::WebDriver::Error::WebDriverError => e
    raise Error, 'Creating episode failed: ', e.message
  end

  def update_episode(work_id:, episode_id:, title:, body:)
    raise NotLoggedInError unless logged_in?

    driver.navigate.to(edit_episode_url(work_id, episode_id))

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
  rescue Selenium::WebDriver::Error::WebDriverError => e
    raise Error, 'Updating episode failed: ', e.message
  end

  def delete_episode(work_id:, episode_id:)
    raise NotLoggedInError unless logged_in?

    driver.navigate.to(edit_episode_url(work_id, episode_id))
    driver.find_element(id: 'contentMainHeader-toolButton').click
    driver.find_element(id: 'contentAsideHeader').find_element(xpath: '//*[contains(text(), "ツール")]').click
    driver.find_element(id: 'deleteEpisode').find_element(tag_name: 'button').click
    driver.switch_to.alert.accept

    Selenium::WebDriver::Wait.new.until do
      driver.find_element(id: 'modelessMessage')
    end
  rescue Selenium::WebDriver::Error::WebDriverError => e
    raise Error, 'Deleting episode failed: ', e.message
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
