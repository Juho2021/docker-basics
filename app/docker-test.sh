#!/bin/bash

cd /app

# ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt update
apt install -y sudo \
  build-essential \
  postgresql-11 \
  chromium-driver \
  python3-selenium

pg_ctlcluster 11 main start

curl -sL https://deb.nodesource.com/setup_12.x | bash
apt update && apt install -y nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt update && apt install -y yarn

bundle install
yarn

cp config/database.yml.example config/database.yml

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

bundle exec rails db:create && \
bundle exec rspec \
  ./spec/system/valuations_spec.rb:296 \
  ./spec/system/valuations_spec.rb:246 \
  ./spec/system/quotes_spec.rb:84 \
  ./spec/system/quotes_spec.rb:178 \
  ./spec/system/valuer_report_spec.rb:30