# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :exreddit,
  username: System.get_env("REDDIT_USER"),
  password: System.get_env("REDDIT_PASS"),
  client_id: System.get_env("REDDIT_CLIENT_ID"),
  secret: System.get_env("REDDIT_SECRET")


config :exreddit_tagger,
  fetch_timeout: 1000,
  initial_threads_to_fetch: 25, # Number of threads to fetch the first time when grabbing new_threads
  threads_to_fetch: 2 # Number of threads to fetch when grabbing new_threads
