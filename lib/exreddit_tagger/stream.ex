defmodule ExRedditTagger.Stream do
  # TODO: Allow user to pass in a starting thread id
  def fetch_new_threads_perpertually(token, sub) do
    Stream.resource(
      fn -> [] end,
      # TODO: Get only newest threads. This starts at the newest and goes oldest.
      fn next -> fetch_10_new_threads(token, sub, [after: next]) end,
      fn _ -> true end
    )
  end

  def fetch_10_new_threads(token, sub, opts \\ []) do
    {:ok, result} = ExReddit.Api.Subreddit.get_new_threads(token, sub, [limit: 10] ++ opts)
    children = Map.get(result, "children")
    after_id = Map.get(result, "after")
    {children, after_id}
  end
end
