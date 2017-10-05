defmodule ExRedditTagger.Stream do
  # TODO: Allow user to pass in a starting thread id
  def fetch_new_threads_perpertually(token, sub) do
    Stream.resource(
      fn -> nil end,
      fn before_id ->
        :timer.sleep 1000
        fetch_new_threads(token, sub, before_id)
      end,
      fn _ -> true end
    )
  end

  defp fetch_new_threads(token, sub, nil) do
    {:ok, result} = ExReddit.Api.Subreddit.get_new_threads(token, sub)
    get_stream_fetch_result(result, nil)
  end
  defp fetch_new_threads(token, sub, before_id) do
    {:ok, result} = ExReddit.Api.Subreddit.get_new_threads(token, sub, [before: before_id])
    get_stream_fetch_result(result, before_id)
  end

  defp get_stream_fetch_result(result, before_id) do
    children = Map.get(result, "children")
    new_before_id = children |> List.first() |> get_before_id(before_id)
    {children, new_before_id}
  end

  defp get_before_id(nil, default) do
    default
  end
  defp get_before_id(data, _) do
    data
    |> Map.get("data")
    |> Map.get("name")
  end
end
