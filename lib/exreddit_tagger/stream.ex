defmodule ExRedditTagger.Stream do
  # TODO: Allow user to pass in a starting thread id
  def fetch_new_threads_perpertually(token, sub) do
    Stream.resource(
      fn -> [] end,
      # TODO: Get only newest threads. This starts at the newest and goes oldest.
      fn next -> fetch_100_new_threads(token, sub, [after: next]) end,
      fn _ -> true end
    )
  end

  def fetch_100_new_threads(token, sub, opts \\ []) do
    result = ExReddit.Api.get_new_threads(token, sub, [limit: 100] ++ opts)
    {result["data"]["children"], result["data"]["after"]}
  end
end
