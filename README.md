# KakuyomuAgent

Selenium script for [Kakuyomu](https://kakuyomu.jp/) episode management.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kakuyomu_agent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kakuyomu_agent

## Usage

```ruby
require 'kakuyomu_agent'

agent = KakuyomuAgent.new(driver: Selenium::WebDriver.for(:chrome))

# ログイン
agent.login!(email: YOUR_EMAIL, password: YOUR_PASSWORD) 

# 小説の URL から work_id を抽出
work_id = KakuyomuAgent::UrlHelper.extract_work_id('https://kakuyomu.jp/works/1234567890123456789') # => 1234567890123456789

# エピソードを執筆
episode_url = agent.create_episode(work_id: work_id, title: 'タイトル', body: '本文')

# エピソードの URL から episode_id を抽出
episode_id = KakuyomuAgent::UrlHelper.extract_episode_id(episode_url)

# エピソードを編集
agent.update_episode(work_id: work_id, episode_id: episode_id, title: '新しいタイトル', body: '新しい本文')

# エピソードを削除
agent.delete_episode(work_id: work_id, episode_id: episode_id) 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuji-nakahara/kakuyomu_agent. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the KakuyomuAgent project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fuji-nakahara/kakuyomu_agent/blob/master/CODE_OF_CONDUCT.md).
