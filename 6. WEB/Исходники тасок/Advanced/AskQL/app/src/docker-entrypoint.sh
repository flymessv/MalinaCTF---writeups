#!/bin/sh
RAILS_ENV="production" bundle exec puma main.ru -v -b tcp://0.0.0.0:8080
