# TODO: Parse title

defmodule ExRedditTagger do
  def get_new_thread_tags(sub, token, tags) do
    ExRedditTagger.Stream.fetch_new_threads_perpertually(token, sub)
    |> Stream.map(&(Map.get(&1, "data")))
    |> Stream.map(&(parse_thread(&1, tags)))
  end

  defp parse_thread(thread, tags) do
    found_tags = parse_tags(thread, tags)
    {Map.get(thread, "id"), found_tags}
  end

  defp parse_tags(thread, tags) do
    body_result = get_tags_from_map(thread, "selftext", tags)
    title_result = get_tags_from_map(thread, "title", tags)
    Enum.concat(title_result, body_result)
  end

  defp get_tags_from_map(thread, property, tags) do
    text = thread
    |> Map.get(property)
    |> String.downcase

    Enum.filter(tags, fn tag -> String.contains?(text, tag) end)
  end
end
