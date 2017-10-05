# ExRedditTagger

Parses new reddit threads to find specific tags in the title or body.

## Installation

Until further development, add the following to Hex:

```elixir
def deps do
  [
    {:exreddit_tagger, git: "https://github.com/making3/exreddit_tagger.git", branch: "master"}
  ]
end
```

## Usage

    {:ok, token} = ExReddit.OAuth.get_token()

    sub = "learnprogramming"
    tags = ["array", "list", "method", "scanf", "class", "api", "post"]

    ExRedditTagger.get_new_thread_tags(sub, token, tags)
    |> Stream.map(&IO.inspect(&1))
    |> Stream.run()
