# kottans-ruby
Kottans Ruby Test Task

# Requirements
PostgreSQL, Redis

# Install

1. Clone repository
2. Run `$ bundle install`
3. Run `$ rackup -p 4567`
4. Open new tab in terminal and run `$ sidekiq -r ./app.rb`
5. And we need redis for sidekiq. In another tab run `$ redis-server`
6. Visit `http://localhost:4567/`

Have a nice day :)
