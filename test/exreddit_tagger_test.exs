defmodule ExRedditTaggerTest do
  use ExUnit.Case
  doctest ExRedditTagger

  test "test run" do
    token = ExReddit.OAuth.get_token()
    IO.puts token

    sub = "learnprogramming"
    tags = ["array", "list", "method", "scanf", "class", "api", "post"]
    ExRedditTagger.get_new_thread_tags(sub, token, tags)
      |> Stream.map(&IO.inspect(&1))
      |> Stream.run
  end
end
