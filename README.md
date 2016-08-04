## Tweetitudes

Tweetitudes is a rails 5.0 application that uses a twitter gem to consume data from the Twitter RESTAPI and the Mashape - Tweet Sentiment Analysis API
### Setup

To get set up with the tweetitude application, clone it
via `git` and pull in gem dependencies with `bundler`:

```sh
$ git clone https://github.com/deborahleehamel/tweetish_sentiments.git
$ cd tweetish_sentiments
$ bundle update
```

And set up the database:

```
bundle exec rake db:{create,setup}
```
