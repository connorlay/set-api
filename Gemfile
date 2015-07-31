source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '4.2.1'
gem 'rails-api'
gem 'spring', :group => :development
gem 'pg'
gem 'bcrypt', '~> 3.1.7'
gem 'jbuilder'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'puma'
gem "active_model_serializers", github: "rails-api/active_model_serializers"


group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'dotenv-rails'
end

group :test do
  gem 'simplecov'
end

group :production do
  gem 'rails_12factor'
end
