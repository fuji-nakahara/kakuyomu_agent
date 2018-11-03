# KakuyomuClient

Client interface for kakuyomu.jp to automate episode management.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kakuyomu_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kakuyomu_client

## Usage

```ruby
require 'kakuyomu_client'

WORK_ID = 1234567890123456789 # URLから取得した小説ID https://kakuyomu.jp/works/#{WORK_ID}

client = KakuyomuClient.new

# エピソードを執筆
episode_id = client.create_episode(work_id: WORK_ID, title: 'タイトル', body: '本文')

# エピソードを編集
client.update_episode(work_id: WORK_ID, episode_id: episode_id, title: '新しいタイトル', body: '新しい本文')

# エピソードを削除
client.delete_episode(work_id: WORK_ID, episode_id: episode_id) 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuji-nakahara/kakuyomu_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the KakuyomuClient project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fuji-nakahara/kakuyomu_client/blob/master/CODE_OF_CONDUCT.md).
