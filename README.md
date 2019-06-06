# Streaming API
API for a tv streaming service.

## Dependencies

* Ruby v2.6.3 
* Rails v5.2.3
* bundler v2.0.1

See Gemfile for more info.

### Installation

Clone the repository, install ruby and bundler.

Install the other dependencies.
```
bundle install
```

Configure the database connection in database.yml

Setup the database.
```
rake db:setup
```

To use caching, please install a rails-compatible cache storage. The software is configured to use Redis.
Other solutions should work ok, but I recomend Redis since it's the one used in development.
In production it's enabled by default. To enable it in development mode run:
```
rails dev:cache
```

## API endpoints

### General data
- movies/: List all movies ordered by creation (oldest first)
- seasons: List all seasons orderd by cration date. Also includes all episodes ordered by number.
- library: List all seasons and movies ordered by creation. It returns both of them in separated categories, so it's really the endpoints 1 and 2 combined.

### User action
These are actions tied to a specific user. They require a X-USER header with the user_id to simulate authentication.

- users/purchase: Allows a user to purchase a season/movie. 
It requires the purchase option id as parameter to identify the selected product and option. It won't allow purchase if the user already purchased the same option and it's stil active. A product is considered active if it was purchased 2 days ago or more recently.

- users/library: Returns all the movies and seasons bought by an user that are active.
It returns them ordered by the time remaning to watch, from less time to more.
It also returns them separatelly, like the index library endpoint.

## Caching

The cached enpoints are movies, seasons and library. 

users/purchase uses queries with inputs, so is not a suitable candidate for caching its queries.
users/library is a volatile endpoint. If cached, it should save a cache for each user active library. 
That cache should be updated at midnight, each time the catalog changes and each time the user buys something. I've considered that those refreshes hinder the performance too much for the benefit the cache gives. More detailed specifications on a real scenario may prove this to be wrong.

## Author
Carles Uroz Taló