defmodule ExRedditTagger.Stream do
  def fetch_new_threads_perpertually(token, sub) do
    Stream.resource(
      fn -> [] end,
      fn previous_thread_ids ->
        :timer.sleep Application.get_env(:exreddit_tagger, :fetch_timeout)
        fetch_new_threads(token, sub, previous_thread_ids)
      end,
      fn _ -> true end
    )
  end

  defp fetch_new_threads(token, sub, []) do
    limit = Application.get_env(:exreddit_tagger, :initial_threads_to_fetch)
    fetch_new_threads(token, sub, [], limit)
  end
  defp fetch_new_threads(token, sub, previous_thread_ids) do
    limit = Application.get_env(:exreddit_tagger, :threads_to_fetch)
    fetch_new_threads(token, sub, previous_thread_ids, limit)
  end

  defp fetch_new_threads(token, sub, previous_thread_ids, limit) do
    {:ok, result} = ExReddit.Api.Subreddit.get_new_threads(token, sub, [limit: limit])
    children = Map.get(result, "children")

    thread_ids = get_thread_ids(children)
    only_new_threads = filter_previous_threads(children, previous_thread_ids)
    {only_new_threads, thread_ids}
  end

  defp get_thread_ids(children) do
    Enum.map(children, &get_thread_id(&1))
  end
  defp get_thread_id(thread) do
    thread
    |> Map.get("data")
    |> Map.get("id")
  end

  defp filter_previous_threads(threads, previous_thread_ids) do
    Enum.filter(threads, &is_new_thread(&1, previous_thread_ids))
  end

  defp is_new_thread(thread, previous_threads_ids) do
    thread_id = get_thread_id(thread)
    Enum.member?(previous_threads_ids, thread_id) == false
  end
end
