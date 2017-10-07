defmodule ExRedditTagger do
  def get_new_thread_tags(sub, token, tags, return_only_matches \\ false) do
    ExRedditTagger.Stream.fetch_new_threads_perpertually(token, sub)
    |> Stream.map(&(Map.get(&1, "data")))
    |> Stream.map(&(parse_thread(&1, tags)))
    |> return_matches(return_only_matches)
  end

  defp parse_thread(thread, tags) do
    found_tags = parse_tags(thread, tags)
    {Map.get(thread, "id"), found_tags}
  end

  defp parse_tags(thread, tags) do
    body_result = get_tags_from_map(thread, "selftext", tags)
    get_tags_from_map(thread, "title", tags)
    |> Enum.concat(body_result)
  end

  defp get_tags_from_map(thread, property, tags) do
    text = thread
    |> Map.get(property)
    |> String.downcase

    Enum.filter(tags, fn tag -> String.contains?(text, tag) end)
  end

  defp return_matches(threads, true) do
    Stream.filter(threads, &should_return_match(&1))
  end
  defp return_matches(threads, _) do
    threads
  end

  defp should_return_match({_, []}), do: false
  defp should_return_match({_, _}), do: true
end
