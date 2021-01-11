source 'https://rubygems.org'
ruby '~> 2.6.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# gems I've installed my damn self
gem 'simple_form', '~> 3.4'
gem 'devise', '~> 4.6', '>= 4.6.2'
gem 'petergate', '~> 1.7', '>= 1.7.5'
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-aws', '~> 1.1'
gem 'mini_magick', '~> 4.7', '>= 4.7.2'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'acts_as_votable', '~> 0.10.0'
gem 'friendly_id', '~> 5.1.0'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'font-awesome-sass', '~> 5.8.1'
gem 'redcarpet', '~> 3.5'
gem 'coderay', '~> 1.1', '>= 1.1.1'
gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
gem 'voltaire', '~> 0.4.5'
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'
gem 'ckeditor', '~> 4.2', '>= 4.2.4'
gem 'twilio-ruby', '~> 5.25.0'

group :development, :test do
  gem 'sqlite3', '~> 1.3', '< 1.4'
  gem 'byebug', platform: :mri
  gem 'faker', '~> 1.7', '>= 1.7.3'
  gem 'pry', '~> 0.10.3'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
