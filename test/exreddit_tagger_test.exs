defmodule ExRedditTaggerTest do
  use ExUnit.Case
  doctest ExRedditTagger

  test "test run" do
    {:ok, token} = ExReddit.OAuth.get_token()

    # sub = "learnprogramming"
    # tags = ["array", "list", "method", "scanf", "class", "api", "post"]

    sub = "askreddit"
    tags = ["what", "how", "when", "who", "why"]
    ExRedditTagger.get_new_thread_tags(sub, token, tags)
      |> Stream.map(&IO.inspect(&1))
      |> Stream.run()
  end
end
