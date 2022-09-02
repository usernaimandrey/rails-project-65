# Project Bulletin board

This is an application in which you can create ads. The user creates an ad and sends it to the administrator for moderation. The application has an admin panel, the administrator publishes ads or sends them for revision.

## Hexlet tests and linter status

[![Actions Status](https://github.com/usernaimandrey/rails-project-65/workflows/hexlet-check/badge.svg)](https://github.com/usernaimandrey/rails-project-65/actions)

## Test and Linter check

[![Test and Linter Check](https://github.com/usernaimandrey/rails-project-65/actions/workflows/ruby.yml/badge.svg)](https://github.com/usernaimandrey/rails-project-65/actions/workflows/ruby.yml)

## Code quality

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

[Demo on Heroku](https://bulletin-board-sh.herokuapp.com/)

## Libraries and technologies:

- [aasm](https://github.com/aasm/aasm)
- [active storage validations](https://github.com/igorkasyanchuk/active_storage_validations)
- [aws sdk s3]()
- [kaminari](https://github.com/amatsuda/kaminari)
- [omniauth-github](https://github.com/omniauth)
- [pundit](https://github.com/varvet/pundit)
- [ransack](https://github.com/activerecord-hackery/ransack)
- [rollbar](https://github.com/rollbar/rollbar-gem)
- [simple form](https://github.com/heartcombo/simple_form)
- [slim rails](https://github.com/slim-template/slim-rails)

### Deploy project locally:

1. clone this repository
  
  ```shell
  git clone https://github.com/usernaimandrey/rails-project-65.git

  ```

2. go to directory

  ```shell
  cd rails-project-lvl2

  ```
  
3. install dependencies
  
  ```shell
  make setup

  ```

4. run

  ```shell
    make start
  ```

open on <http://0.0.0.0:3000/>
