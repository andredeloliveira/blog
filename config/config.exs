# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :blog,
  ecto_repos: [Blog.Repo],
  origin: ["http://localhost:3000"]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cM75r5/lmrkuc0I3/4EbAbpLJgJF9X5o5oiSkMra+o1zhL3BdH9e5EGozatRfC4c",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blog.PubSub, adapter: Phoenix.PubSub.PG2],
  check_origin: ["http://localhost:3000"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :blog, BlogWeb.Guardian,
  issuer: "blog",
  # change the location to a envoironment var
  secret_key: "j5SX20DJ/duDBG+Www2TBstWRUGKUBZAkiXqdGCWKJxjcgT6sN3uwX29efVxD7Vs"

config :blog, Blog.Guardian,
  issuer: "Blog",
  secret_key: "QL1JKSoSJda/wV1IcZ1NjJZtk21vOjUA2ByUt1mraxjXMfhspWpdPKrI/TE0Pmez",
  permissions: %{
    default: [:read_users, :write_users, :admin]
  }

config :ueberauth, Ueberauth,
  base_path: "/auth",
  providers: [
    identity:
      {Ueberauth.Strategy.Identity,
       [
         callback_methods: ["POST"],
         nickname_field: :username,
         param_nesting: "user",
         uid_field: :username
       ]}
  ]

config :blog, BlogWeb.Plug.AuthAccessPipeline,
  module: Blog.Guardian,
  error_handler: BlogWeb.Plug.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
