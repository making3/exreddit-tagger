defmodule ExRedditTaggerTest do
  use ExUnit.Case
  doctest ExRedditTagger

  test "test run" do
    {:ok, token} = ExReddit.OAuth.get_token()

    sub = "learnprogramming"
    tags = ["array", "list", "method", "scanf", "class", "api", "post"]
    ExRedditTagger.get_new_thread_tags(sub, token, tags)
      |> Stream.map(&IO.inspect(&1))
      |> Enum.take(5)
  end
end
