defmodule GotQuotesApiWeb.QuotesJSON do
  alias GotQuotesApi.Quotes.Quote

  def index(%{quotes: quotes}) do
    %{data: Enum.map(quotes, &quote_json/1)}
  end

  def random(%{random_quote: random_quote}) do
    %{data: quote_json(random_quote)}
  end

  defp quote_json(%Quote{} = quote) do
    %{
      id: quote.id,
      sentence: quote.sentence,
      character: quote.character
    }
  end
end
