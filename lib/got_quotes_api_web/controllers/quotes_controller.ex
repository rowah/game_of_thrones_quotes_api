defmodule GotQuotesApiWeb.QuotesController do
  use Phoenix.Controller, formats: [:json]

  alias GotQuotesApi.Quotes

  def index(conn, _params) do
    quotes = Quotes.list_quotes()
    render(conn, :index, quotes: quotes)
  end

  def random(conn, _params) do
    random_quote = Quotes.get_random_quote()
    render(conn, :random, random_quote: random_quote)
  end
end
