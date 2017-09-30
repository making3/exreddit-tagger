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
    text = Map.get(thread, "selftext")
      |> String.downcase
    Enum.filter(tags, fn tag -> String.contains?(text, tag) end)
  end
end
