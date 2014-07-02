#!/bin/bash
cd /rails
source /etc/profile.d/rvm.sh
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rails s -d -p 8080
nginx
