require 'selenium-webdriver'

require_relative 'kakuyomu_agent/url_helper'
require_relative 'kakuyomu_agent/action'
require_relative 'kakuyomu_agent/error'
require_relative 'kakuyomu_agent/version'

require_relative 'kakuyomu_agent/actions/create_episode'
require_relative 'kakuyomu_agent/actions/delete_episode'
require_relative 'kakuyomu_agent/actions/login'
require_relative 'kakuyomu_agent/actions/update_episode'

class KakuyomuAgent
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
    Actions::Login.new(self).run(email, password)
    @logged_in = true
  end

  def create_episode(work_id:, title:, body:, date: nil)
    raise NotLoggedInError unless logged_in?
    Actions::CreateEpisode.new(self).run(work_id, title, body, date)
  end

  def update_episode(work_id:, episode_id:, title:, body:)
    raise NotLoggedInError unless logged_in?
    Actions::UpdateEpisode.new(self).run(work_id, episode_id, title, body)
  end

  def delete_episode(work_id:, episode_id:)
    raise NotLoggedInError unless logged_in?
    Actions::DeleteEpisode.new(self).run(work_id, episode_id)
  end
end
