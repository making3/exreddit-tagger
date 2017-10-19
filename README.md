# ExRedditTagger

Parses new reddit threads to find specific tags in the title or body.

## Installation

Add the following to Hex:

```elixir
def application do
  [
    applications: [:exreddit]
  ]
end

def deps do
  [
    {:exreddit_tagger, git: "https://github.com/making3/exreddit_tagger.git", branch: "master"}
  ]
end

```

Then run `mix deps.get`.

## Configuration

Configuration includes ExReddit settings (reddit api settings) and the below:

    config :exreddit_tagger,
      fetch_timeout: 1000,
      initial_threads_to_fetch: 25, # Number of threads to fetch the first time when grabbing new_threads
      threads_to_fetch: 2 # Number of threads to fetch when grabbing new_threads

## Usage

    {:ok, token} = ExReddit.OAuth.get_token()

    sub = "learnprogramming"
    tags = ["array", "list", "method", "scanf", "class", "api", "post"]
    return_only_matches = true # defaults to false

    ExRedditTagger.get_new_thread_tags(sub, token, tags, return_only_matches)
    |> Stream.map(&IO.inspect(&1))
    |> Stream.run()
