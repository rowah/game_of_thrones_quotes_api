defmodule GotQuotesApi.QuotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GotQuotesApi.Quotes` context.
  """

  @doc """
  Generate a quote.
  """
  def quote_fixture(attrs \\ %{}) do
    {:ok, quote} =
      attrs
      |> Enum.into(%{
        character: %{},
        sentence: "some sentence"
      })
      |> GotQuotesApi.Quotes.create_quote()

    quote
  end
end
