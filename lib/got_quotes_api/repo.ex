defmodule GotQuotesApi.Repo do
  use Ecto.Repo,
    otp_app: :got_quotes_api,
    adapter: Ecto.Adapters.Postgres
end
