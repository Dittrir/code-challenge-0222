# Ruby on Rails Code Project

[![Dittrir commits](https://badgen.net/github/commits/Naereen/StrapDown.js)](https://GitHub.com/Dittrir/code-challenge-0222/commits?author=Dittrir)
![languages](https://img.shields.io/github/languages/top/Dittrir/code-challenge-0222?color=red)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->


## Description
This mini project models a barebones User Interface. Users can register and then must be authenticated before logging in. Users can create posts, comment on others' posts, and delete posts. As part of our consideration for new hires to the Ruby on Rails dev teams, I have completed this project to the best of my ability.

## Project Requirements
- Use latest version of Rails 5 or greater
- Use Postgres for the database
- Use Ruby 2.6 or newer (we use 2.6.9 on our main project)
- Use Rspec to add tests that cover critical behavior
- Paginate posts#index and/or posts#show (comments)
- Deploy project to Heroku

## Schema


## Local Setup
1. Fork and Clone the repo 
```shell
$ it clone git@github.com:Dittrir/code-challenge-0222.git
```
2.  Navigate to directory 
```shell
$ cd code-challenge-0222
```
3. Install gem packages:
```shell
$ bundle install
```
4. Update gem packages: 
```shell
$ bundle update
```
5. Set up the schema and run the migrations: 
```shell
$ rails db:{drop,create,migrate,seed}
```

## Versions
- Ruby 2.7.2
- Rails 5.2.6


# Gems
- `gem 'pry'`
- `gem 'jsonapi-serializer'`
- `gem 'rspec-rails'`
- `gem 'factory_bot_rails'`
- `gem 'faker', github: 'stympy/faker'`
- `gem 'simplecov', require: false, group: :test`


## Author

<a href="https://github.com/Dittrir/rails-engine/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Dittrir/rails-engine" />
</a>

Robin Dittrich
