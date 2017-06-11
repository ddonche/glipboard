source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# gems I've installed my damn self
gem 'simple_form', '~> 3.4'
gem 'devise', '~> 4.2', '>= 4.2.1'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick', '~> 4.5', '>= 4.5.1'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'font-awesome-sass', '~> 4.2.0'
gem 'acts_as_votable', '~> 0.10.0'
gem 'friendly_id', '~> 5.1.0'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'redcarpet', '~> 3.4'
gem 'coderay', '~> 1.1', '>= 1.1.1'
gem 'petergate', '~> 1.7', '>= 1.7.5'
gem 'faker', '~> 1.7', '>= 1.7.3'
gem 'carrierwave-aws', '~> 1.1'
gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
gem 'voltaire', '~> 0.4.5'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
