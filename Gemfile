source 'https://rubygems.org'

gem "office_clerk" , :github => "rubyclerks/office_clerk"
#gem "office_clerk", path: "../office_clerk"

gem 'accountant_clerk' , github: "rubyclerks/accountant_clerk"
#gem 'accountant_clerk' , path: "../accountant_clerk"

gem 'print_clerk' , github: "rubyclerks/print_clerk"
#gem 'print_clerk' , path: "../print_clerk"
gem 'post_clerk' ,  github: "rubyclerks/post_clerk"

gem 'db_fixtures_dump'  , github: "dancinglightning/db_fixtures_dump" #backup

gem "json_pure"
gem 'sqlite3'

gem 'susy'

gem "haml"

#one wishes one would not need it. alas . . .
gem 'rack-attack'

gem 'rails-i18n', '~> 4.0.0'

group  :production do
  gem "therubyracer"
  gem "libv8"
  gem 'uglifier', '>= 1.3.0'
  gem 'newrelic_rpm'
  gem "mysql2" , "~> 0.3.13"
end

group :development do
  gem "quiet_assets"
  gem "binding_of_caller" , :platform => [:mri_20 , :mri_21 ]
  gem "better_errors" , :platform => [:mri_20 , :mri_21 ]
  gem "thin"
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem "mechanize"
  gem 'database_cleaner'
  gem "factory_girl_rails"
  gem 'i18n-spec'
  gem 'guard'
  gem 'guard-rspec'
end
