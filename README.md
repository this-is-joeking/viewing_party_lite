# Viewing Party
![Known Vulnerabilities](https://snyk.io/test/github/this-is-joeking/viewing_party_lite/badge.svg)
![Github CI](https://github.com/Listen-Up-2210/listen_up_be/actions/workflows/rubyonrails.yml/badge.svg)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
### About this Project

Viewing Party Lite is an application in which users can explore movie options and create a viewing party event for themselves and other users of the application.

Live application can be found [here](https://movie-viewing-party.herokuapp.com/)

## Setup

1. Fork and Clone the repo
1. Install gem packages: `bundle install`
1. Setup the database: `rails db:create,migrate,seed`
1. Setup your api key: Create an account and request an API key from [The Movie Database](https://www.themoviedb.org/signup)
1. Install figaro: `bundle exec figaro install`
1. In the config/application.yml file add: `TMDB_API_KEY: <TMDB API KEY GOES HERE>`
1. Run the server: `rails s`
1. In your browser navigate to `http://localhost:3000`

To run the test suite in the terminal: `bundle exec rspec`

## Learning Goals
- Consume a JSON API that requires authentication
- Implement authentication/authorization of users using `bcrypt`
- Use facades/services/poros to organize code and abstract logic from the controller

## Built with:

- Ruby 2.7.4
- Rails 5.2.8.1
- RSpec

# Contributors
| <img src="https://github.com/this-is-joeking.png" width="60"> | <img src="https://github.com/bflanagan138.png" width="60"> |
|:---:|:---:|
|**Joe King**|**Bryan Flanagan**|
|[<img src="https://user-images.githubusercontent.com/54966635/228695316-4ace3a9e-d3a1-4063-b5f5-cd6e5294c585.png" alt= “” width="35">](https://github.com/this-is-joeking)  [<img src="https://user-images.githubusercontent.com/54966635/228696723-e343f994-8860-4c35-9a89-5f34b7abb705.png" alt= “” width="35">](https://www.linkedin.com/in/king-joseph/)| [<img src="https://user-images.githubusercontent.com/54966635/228695316-4ace3a9e-d3a1-4063-b5f5-cd6e5294c585.png" alt= “” width="35">](https://github.com/bflanagan138)  [<img src="https://user-images.githubusercontent.com/54966635/228696723-e343f994-8860-4c35-9a89-5f34b7abb705.png" alt= “” width="35">](https://www.linkedin.com/in/bryanflanagan138/)| 

# Attributions
This project gets all move related data from [The Movie Database](https://developers.themoviedb.org/3/getting-started/introduction)
