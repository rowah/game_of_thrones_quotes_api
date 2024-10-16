# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GotQuotesApi.Repo.insert!(%GotQuotesApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias GotQuotesApi.Quotes
require Logger

defmodule GOTQuotesSeeder do
  # Fetch 100 random quotes every time I run the seeds file
  @api_url "https://api.gameofthronesquotes.xyz/v1/random/700"

  def fetch_and_seed_quotes do
    case HTTPoison.get!(@api_url) do
      %HTTPoison.Response{
        status_code: 200,
        body: body
      } ->
        {:ok, quotes} = Jason.decode(body)
        save_quotes(quotes)

      {%HTTPoison.Response{status_code: status_code}} ->
        Logger.error("Failed to fetch quotes. Status code: #{status_code}")
        :error

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Error occurred: #{inspect(reason)}")
        :error
    end
  end

  defp save_quotes(quotes) do
    Enum.each(quotes, fn %{"character" => character, "sentence" => content} ->
      Quotes.create_quote(%{character: character, sentence: content})
    end)

    Logger.info("Quotes successfully inserted into the database.")
  end
end

GOTQuotesSeeder.fetch_and_seed_quotes()
