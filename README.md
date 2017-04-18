# webpacktest
Add these buildpacks to make it work
heroku buildpacks:add heroku/php
heroku buildpacks:add --index 2 heroku/nodejs
heroku buildpacks:add --index 3 https://github.com/frc/heroku-buildpack-webpack
