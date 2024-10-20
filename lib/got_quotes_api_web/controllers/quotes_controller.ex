defmodule GotQuotesApiWeb.QuotesController do
  use Phoenix.Controller, formats: [:json]

  # use verified routes
  use Phoenix.VerifiedRoutes,
    endpoint: GotQuotesApiWeb.Endpoint,
    router: GotQuotesApiWeb.Router

  alias GotQuotesApi.Quotes
  alias GotQuotesApi.Quotes.Quote
  # alias GotQuotesApiWeb.Router.Helpers, as: Routes

  def index(conn, _params) do
    quotes = Quotes.list_quotes()
    render(conn, :index, quotes: quotes)
  end

  def show(conn, %{"id" => id}) do
    quote = Quotes.get_quote!(id)
    render(conn, :show, quote: quote)
  end

  def random(conn, _params) do
    random_quote = Quotes.get_random_quote()
    render(conn, :random, random_quote: random_quote)
  end

  def create(conn, %{"quote" => quote_params}) do
    with {:ok, %Quote{} = quote} <- Quotes.create_quote(quote_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/quotes/#{quote.id}")
      |> render(:show, quote: quote)
    end
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Quotes.get_quote!(id)

    with {:ok, %Quote{} = quote} <- Quotes.update_quote(quote, quote_params) do
      render(conn, :show, quote: quote)
    end
  end
end
