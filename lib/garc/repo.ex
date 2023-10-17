defmodule Garc.Repo do
  use Ecto.Repo,
    otp_app: :garc,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
